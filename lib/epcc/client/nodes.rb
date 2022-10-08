# frozen_string_literal: true

module EPCC
  class Client
    # Module for interacting with nodes
    module Nodes
      # Get a single node
      #
      # @param hierarchy_id [String] The UUID of the hierarchy
      # @param node_id [String] The UUID of the node
      def node(hierarchy_id, node_id)
        get("/pcm/hierarchies/#{hierarchy_id}/nodes/#{node_id}")
      end

      # Create a node
      #
      # @param hierarchy_id [String] The UUID of the hierarchy
      # @option options [Hash] data The node data
      def create_node(hierarchy_id, options)
        post("/pcm/hierarchies/#{hierarchy_id}/nodes", { body: options })
      end

      # Delete a node
      #
      # @param hierarchy_id [String] The UUID of the hierarchy
      # @param node_id [String] The UUID of the node
      def delete_node(hierarchy_id, node_id)
        delete("/pcm/hierarchies/#{hierarchy_id}/nodes/#{node_id}")
      end

      # Get a node's products
      #
      # @param hierarchy_id [String] The UUID of the hierarchy
      # @param node_id [String] The UUID of the node
      def get_node_products(hierarchy_id, node_id)
        get("/pcm/hierarchies/#{hierarchy_id}/nodes/#{node_id}/products")
      end

      # Attach product(s) to a node
      # This method accepts any number of arguments after the node UUID,
      # each representing a different product UUID
      #
      # @param hierarchy_id [String] The UUID of the hierarchy
      # @param node_id [String] The UUID of the node
      # @param product_ids [String] The UUID of the product
      def attach_products_to_node(hierarchy_id, node_id, *product_ids)
        data = []

        (product_ids || []).each do |id|
          data.push({
            type: 'product',
            id: id,
          })
        end

        post("/pcm/hierarchies/#{hierarchy_id}/nodes/#{node_id}/relationships/products", {
          body: {
            data: data,
          }
        })
      end

      # Removes product(s) from a node
      # This method accepts any number of arguments after the node UUID,
      # each representing a different product UUID
      #
      # @param hierarchy_id [String] The UUID of the hierarchy
      # @param node_id [String] The UUID of the node
      # @param product_ids [String] The UUID of the product
      def remove_products_from_node(hierarchy_id, node_id, *product_ids)
        data = []

        (product_ids || []).each do |id|
          data.push({
            type: 'product',
            id: id,
          })
        end

        delete("/pcm/hierarchies/#{hierarchy_id}/nodes/#{node_id}/relationships/products", {
          body: {
            data: data,
          }
        })
      end

      # Moves nodes under a parent node
      def move_nodes(hierarchy_id, node_id, *node_ids)
        data = []

        (node_ids || []).each do |id|
          data.push({
            type: 'node',
            id: id,
          })
        end

        post("/pcm/hierarchies/#{hierarchy_id}/nodes/#{node_id}/relationships/children", {
          body: {
            data: data,
          }
        })
      end

      # Moves a node to a different parent node
      def change_node_parent(hierarchy_id, parent_node_id, node_id)
        post("/pcm/hierarchies/#{hierarchy_id}/nodes/#{parent_node_id}", {
          body: {
            data: {
              type: 'node',
              id: node_id,
            }
          }
        })
      end
    end
  end
end
