# frozen_string_literal: true

require 'epcc/request'
require 'epcc/inflector'

module EPCC
  module Resources
    # Base methods for all resources
    class Base
      def self.required_attributes(*attrs)
        return @required_attributes if attrs.count.zero?

        @required_attributes ||= []
        attrs.each do |a|
          @required_attributes.push(a)
        end
      end

      def self.api_version(version = nil)
        return @api_version unless version

        @api_version = version
      end

      def initialize(attrs)
        @attributes = attrs
      end

      def valid?
        errors = []
        self.class.required_attributes.each do |attr|
          errors.push("#{attr} is a required field") unless @attributes.key?(attr)
        end

        raise EPCC::InvalidResource, errors.join(', ') unless errors.count.zero?

        true
      end

      def create
        return unless valid?

        plural = EPCC::Inflector.pluralize(resource_name)

        @response = EPCC.client.post("/#{self.class.api_version}/#{plural}", {
          body: {
            data: {
              type: resource_name,
              attributes: @attributes,
            }
          }
        })
      end

      def success?
        return false unless @response

        false if @response.is_a?(EPCC::ClientError)
      end

      def data
        return [] unless success?

        @response.data
      end

      def errors
        return [] if success?

        @response
      end

      def resource_name
        self.class.name.downcase.gsub!('epcc::resources::', '')
      end
    end
  end
end
