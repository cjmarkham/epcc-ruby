# frozen_string_literal: true

require 'httparty'
require 'json'

module EPCC
  # Module to send requests to the API via HTTParty
  module Request
    %w[get put post delete].each do |method|
      define_method(method) do |path, options = {}|
        params = options.dup
        params[:headers] ||= {}
        params[:headers].merge!({ Authorization: "Bearer: #{@access_token}" })

        url = url_from_options(path, options)

        begin
          response = HTTParty.send(method, url, params)
          handle_response(response)
        rescue StandardError => e
          # TODO: Better error handling
          raise e
        end
      end
    end

    def handle_response(response)
      status = response.code
      body = response.body

      return EPCC::Error.response_error(response) if (400..599).include?(status)

      JSON.parse(body)
    end

    # TODO: Filter parsing is rudamentry and ugly
    # It will also only allow one filter, no chaining
    def url_from_options(path, options = {})
      base = "#{@api_endpoint}#{path}?"
      queries = []

      filter = options.delete(:filter)
      filter_data = filter&.each_with_object({}) do |(key, value), data|
        data[key.to_s] = value.map { |k, v| "#{k},#{v}" }
      end

      filter_query = filter_data&.map{ |k, v| "#{k}(#{v[0]})" }
      queries.push("filter=#{filter_query[0]}") if filter_query

      # TODO: This assumes pagination options only
      options.map do |key, value|
        queries.push("page[#{key}]=#{value}")
      end

      base + queries.join('&')
    end
  end
end
