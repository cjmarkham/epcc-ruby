# frozen_string_literal: true

require 'epcc/authentication'
require 'epcc/client/products'
require 'epcc/client/hierarchies'
require 'epcc/client/nodes'
require 'epcc/client/catalogs'
require 'epcc/client/pricebooks'

module EPCC
  # EPCC Client to communicate with the EPCC API
  class Client
    include EPCC::Authentication
    include EPCC::Request
    include EPCC::Client::Products
    include EPCC::Client::Hierarchies
    include EPCC::Client::Nodes
    include EPCC::Client::Catalogs
    include EPCC::Client::Pricebooks

    attr_writer :api_endpoint, :client_id, :client_secret

    def initialize(options = {})
      EPCC::Configuration.options.each do |option|
        value = options[option].nil? ? EPCC.instance_variable_get("@#{option}") : options[option]
        instance_variable_set("@#{option}", value)
      end
    end
  end
end
