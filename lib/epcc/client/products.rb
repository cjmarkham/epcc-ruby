require 'epcc/request'

module EPCC
  class Client
    # Module for interacting with products
    module Products
      # List products
      #
      # @option options [String] :limit Limits the number of returned products
      # @option options [String] :offset The page offset
      # @option options [Hash] :filter The filter to apply to the request
      #   Example { eq: { sku: 'Foobar' } }
      def products(options = {})
        get('/pcm/products', options)
      end

      # Gets a single product
      # @param id [String] The ID of the product
      def product(id)
        get("/pcm/products/#{id}")
      end
    end
  end
end
