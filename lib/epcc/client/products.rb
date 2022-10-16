# frozen_string_literal: true

module EPCC
  class Client
    # Module for interacting with products
    module Products
      # List products
      #
      # @option options [String] :limit Limits the number of returned products
      # @option options [String] :offset The page offset
      # @option options [Hash] :filter The filter to apply to the request
      # @option options [Hash] :pagination The pagination to apply to the request
      #
      # @example client.products({ eq: { sku: 'Foobar' } })
      # @example client.products({ page: { limit: 10, offset: 0 } })
      def products(options = {})
        get('/pcm/products', options)
      end

      # Get a single product
      #
      # @param id [String] The UUID of the product
      def product(id)
        get("/pcm/products/#{id}")
      end

      # Create a product
      #
      # @param options [Hash] The options to create the product
      #
      # @option options [Hash] :data The data for the product
      def create_product(options)
        post('/pcm/products', { body: options })
      end

      # Delete a product
      #
      # @param id [String] The UUID of the product
      def delete_product(id)
        delete("/pcm/products/#{id}")
      end
    end
  end
end
