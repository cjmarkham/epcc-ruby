# frozen_string_literal: true

require 'epcc/version'
require 'epcc/configuration'
require 'epcc/error'
require 'epcc/default'
require 'epcc/client'
require 'epcc/request'
require 'epcc/response'
require 'epcc/resources/base'
require 'epcc/resources/product'

# EPCC module
module EPCC
  class << self
    include EPCC::Configuration

    attr_writer :client

    def client
      @client if defined?(@client)
    end
  end
end

EPCC.reset!
