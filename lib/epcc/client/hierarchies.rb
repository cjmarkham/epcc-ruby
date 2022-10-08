# frozen_string_literal: true

module EPCC
  class Client
    # Module for interacting with hierarchies
    module Hierarchies
      # List hierarchies
      #
      # @option options [String] :limit Limits the number of returned hierarchies
      # @option options [String] :offset The page offset
      # @option options [Hash] :filter The filter to apply to the request
      # @option options [Hash] :pagination The pagination to apply to the request
      # @example client.hierarchies({ eq: { sku: 'Foobar' } })
      # @example client.hierarchies({ page: { limit: 10, offset: 0 } })
      def hierarchies(options = {})
        get('/pcm/hierarchies', options)
      end

      # Get a single hierarchy
      #
      # @param id [String] The UUID of the hierarchy
      def hierarchy(id)
        get("/pcm/hierarchies/#{id}")
      end

      # Create a hierarchy
      #
      # @param options [Hash] The options to create the hierarchy
      #
      # @option options [Hash] :data The data for the hierarchy
      def create_hierarchy(options)
        post('/pcm/hierarchies', { body: options })
      end

      # Delete a hierarchy
      #
      # @param id [String] The UUID of the hierarchy
      def delete_hierarchy(id)
        delete("/pcm/hierarchies/#{id}")
      end
    end
  end
end
