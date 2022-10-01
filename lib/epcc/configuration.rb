# frozen_string_literal: true

module EPCC
  # Module to configure EPCC client
  module Configuration
    attr_accessor :api_endpoint, :client_id, :client_secret

    class << self
      def options
        @options ||= %i[api_endpoint client_id client_secret].freeze
      end
    end

    def configure
      yield self
    end

    def reset!
      EPCC::Configuration.options.each do |option|
        instance_variable_set("@#{option}", EPCC::Default.options[option])
      end
    end
  end
end
