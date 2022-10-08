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
    end
  end
end
