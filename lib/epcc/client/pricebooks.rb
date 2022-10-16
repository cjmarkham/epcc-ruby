# frozen_string_literal: true

module EPCC
  class Client
    # Module for interacting with pricebooks
    module Pricebooks
      # List pricebooks
      #
      # @option options [String] :limit Limits the number of returned pricebooks
      # @option options [String] :offset The page offset
      # @option options [Hash] :filter The filter to apply to the request
      # @option options [Hash] :pagination The pagination to apply to the request
      #
      # @example client.pricebooks({ eq: { name: 'Foobar' } })
      # @example client.pricebooks({ page: { limit: 10, offset: 0 } })
      def pricebooks
        get('/pcm/pricebooks')
      end

      # Get a single pricebook
      #
      # @param pricebook_id [String] The UUID of the pricebook
      def pricebook(pricebook_id)
        get("/pcm/pricebooks/#{pricebook_id}")
      end

      # Create a pricebook
      #
      # @param options [Hash] The options to create the pricebook
      #
      # @option options [Hash] :data The data for the pricebook
      def create_pricebook(options)
        post('/pcm/pricebooks', { body: options })
      end

      # Delete a pricebook
      #
      # @param pricebook_id [String] The UUID of the pricebook
      def delete_pricebook(pricebook_id)
        delete("/pcm/pricebooks/#{pricebook_id}")
      end
    end
  end
end
