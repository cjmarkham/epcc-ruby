# frozen_string_literal: true

module EPCC
  # Helper methods for API responses
  class Response
    NO_BODY_STATUS = %i[204 405]

    def initialize(response)
      @response = response
    end

    def status
      @response.code.to_i
    end

    def success?
      (200..399).include?(status)
    end

    def failure?
      !success?
    end

    def json
      JSON.parse(@response.body)
    end

    def struct
      JSON.parse(@response.body, object_class: OpenStruct)
    end

    def body?
      @response.body != '' && !NO_BODY_STATUS.include?(status) && !@response.body.nil?
    end
  end
end
