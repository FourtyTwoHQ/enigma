module Enigma

  class Item
    attr_reader :key
    attr_reader :property_name
    attr_reader :value

    def initialize(hash: Hash)
      @key = hash['key']
      @property = hash['property_name']
      @value = ''
    end
  end

end
