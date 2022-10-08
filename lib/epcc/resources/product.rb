# frozen_string_literal: true

module EPCC
  module Resources
    # Model definitions for a product
    class Product < Base
      required_attributes :name,
        :description,
        :slug,
        :commodity_type

      api_version :pcm
    end
  end
end
