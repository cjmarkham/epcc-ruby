# frozen_string_literal: true

module EPCC
  class Inflector
    # Pluralizes a word
    #
    # @todo This needs a map for more complex words
    def self.pluralize(word)
      "#{word}s"
    end
  end
end
