# frozen_string_literal: true

require 'epcc/version'
require 'epcc/configuration'
require 'epcc/error'
require 'epcc/default'
require 'epcc/client'
require 'epcc/response'

module EPCC
  class << self
    include EPCC::Configuration
  end
end

EPCC.reset!
