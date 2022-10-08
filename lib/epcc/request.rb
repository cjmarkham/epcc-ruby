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
        params[:headers].merge!({
          Authorization: "Bearer: #{@access_token}",
          Accept: 'application/json',
        })
        params[:headers]['Content-Type'] = 'application/json' unless params[:headers].key?(:'Content-Type')
        params[:body] = params[:body].to_json if params[:body] && params[:headers]['Content-Type'] == 'application/json'

        url = url_from_options(path, options)

        begin
          response = HTTParty.send(method, url, params)
          res = EPCC::Response.new(response)

          return EPCC::Error.response_error(response) if res.failure?

          return nil unless res.body?
          return res.json if EPCC.response_type == 'json'
          return res.struct if EPCC.response_type == 'struct'
        rescue StandardError => e
          # TODO: Better error handling
          raise e
        end
      end
    end

    def url_from_options(path, options = {})
      base = "#{@api_endpoint}#{path}?"

      filter_str = filter_from_hash(options[:filter])
      pagination_str = pagination_from_hash(options[:pagination])

      base + filter_str + pagination_str
    end

    # Converts a hash of filters to a query string
    #
    # @param filter [Hash]
    #   Example:
    #     {eq: [{name: 'foo'}, {sku: 'bar'}], like: [{status: 'live'}]}
    #     >> filter=eq(name,foo):eq(sku,bar):like(status,live)
    def filter_from_hash(filter)
      return '' unless filter

      filters = []

      filter.each do |operator, conditions|
        conditions.each_key do |key|
          filters.push("#{operator}(#{key},#{conditions[key]})")
        end
      end

      "filter=#{filters.join(':')}"
    end

    # Converts a hash of pagination options to a query string
    #
    # @param pagination [Hash]
    #   Example:
    #     { limit: 10, offset: 0 }
    #     >> page[limit]=10&page[offset]=0
    def pagination_from_hash(pagination)
      return '' unless pagination

      filtered = pagination.filter do |k|
        %i[limit offset].include?(k)
      end

      filtered.keys.map do |k|
        "page[#{k}]=#{pagination[k]}"
      end.join('&')
    end
  end
end
