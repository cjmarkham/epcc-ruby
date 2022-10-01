# frozen_string_literal: true

module EPCC
  # Default options for configuration
  module Default
    API_ENDPOINT = 'https://api.moltin.com'

    class << self
      def options
        EPCC::Configuration.options.map { |option| [option, send(option)] }.to_h
      end

      def api_endpoint
        ENV.fetch('EPCC_API_ENDPOINT') { API_ENDPOINT }
      end

      def client_id
        ENV.fetch('EPCC_CLIENT_ID') do
          raise EPCC::Error::NoClientID
        end
      end

      def client_secret
        ENV.fetch('EPCC_CLIENT_SECRET')
      end
    end
  end
end
