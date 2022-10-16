# frozen_string_literal: true

module EPCC
  class Client
    # Module for interacting with catalogs
    module Catalogs
      # List catalogs
      #
      # @option options [String] :limit Limits the number of returned catalogs
      # @option options [String] :offset The page offset
      # @option options [Hash] :filter The filter to apply to the request
      # @option options [Hash] :pagination The pagination to apply to the request
      #
      # @example client.catalogs({ eq: { name: 'Foobar' } })
      # @example client.catalogs({ page: { limit: 10, offset: 0 } })
      def catalogs
        get('/pcm/catalogs')
      end

      # Get a single catalog
      #
      # @param catalog_id [String] The UUID of the catalog
      def catalog(catalog_id)
        get("/pcm/catalogs/#{catalog_id}")
      end

      # Update a catalog
      #
      # @param catalog_id [String] The UUID of the catalog
      # @param options [Hash] The new options for the catalog
      #
      # @option options [String] :name The name of the catalog
      # @option options [String] :description The description of the catalog
      def update_catalog(catalog_id, options)
        put("/pcm/catalogs/#{catalog_id}", { body: options })
      end

      # Create a catalog
      #
      # @param options [Hash] The catalog options
      #
      # @option options [String] :name The name of the catalog
      # # @option options [String] :description The description of the catalog
      # @option options [Array] :hierarchy_ids The UUIDs of the hierarchies
      # @option options [String] :pricebook_id The UUID of the pricebook
      def create_catalog(options)
        post('/pcm/catalogs', { body: options })
      end
    end
  end
end
