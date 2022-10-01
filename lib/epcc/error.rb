module EPCC
  # Error handlers
  class Error < StandardError
    def self.response_error(response)
      status = response.code.to_i

      if (klass = case status
                  when 400 then EPCC::BadRequest
                  when 401 then EPCC::Unauthorized
                  when 403 then EPCC::Forbidden
                  when 404 then EPCC::NotFound
                  when 422 then EPCC::UnprocessableEntity
      end)

        klass.new(response)
      end
    end
  end

  class ClientError < Error; end

  class BadRequest < ClientError; end

  class Forbidden < ClientError; end

  class NotFound < ClientError; end

  class Unauthorized < ClientError; end

  class UnprocessableEntity < ClientError; end

  class NoClientID < Error; end
end
