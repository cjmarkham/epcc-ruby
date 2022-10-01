require 'epcc/authentication'
require 'epcc/client/products'

module EPCC
  # EPCC Client to communicate with the EPCC API
  class Client
    include EPCC::Authentication
    include EPCC::Request
    include EPCC::Client::Products

    attr_writer :api_endpoint, :client_id, :client_secret

    def initialize(options = {})
      EPCC.reset!

      EPCC::Configuration.options.each do |option|
        value = options[option].nil? ? EPCC.instance_variable_get("@#{option}") : options[option]
        instance_variable_set("@#{option}", value)
      end
    end
  end
end
