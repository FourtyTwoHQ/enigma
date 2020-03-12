module Enigma

  class Item
    attr_reader :key
    attr_reader :property_name
    attr_accessor :value

    def initialize(hash: Hash)
      hash = hash.transform_keys(&:to_sym)
      @key = hash[:key]
      @property_name = hash[:property_name]
      @value = ''
    end
  end

end
