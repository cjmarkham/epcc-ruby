# frozen_string_literal: true

module EPCC
  # Error handlers
  class Error < StandardError
    @response = nil

    def initialize(response)
      @response = response

      super
    end

    def response_error
      klass = case status
        when 400 then EPCC::BadRequest
        when 401 then EPCC::Unauthorized
        when 403 then EPCC::Forbidden
        when 404 then EPCC::NotFound
        when 405 then EPCC::MethodNotAllowed
        when 409 then EPCC::Conflict
        when 422 then EPCC::UnprocessableEntity
        else EPCC::BadRequest
      end

      klass&.new(@response)
    end

    def errors
      @response['errors']
    end

    def status
      @response.code.to_i
    end
  end

  class ClientError < Error; end

  class BadRequest < ClientError; end

  class Forbidden < ClientError; end

  class NotFound < ClientError; end

  class Unauthorized < ClientError; end

  class UnprocessableEntity < ClientError; end

  class NoClientID < Error; end

  class MethodNotAllowed < ClientError; end

  class Conflict < ClientError; end
end
