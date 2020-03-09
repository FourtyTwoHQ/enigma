module Enigma

  class Item
    attr_reader :key
    attr_reader :property_name
    attr_accessor :value

    def initialize(hash: Hash)
      @key = hash['key']
      @property_name = hash['property_name']
      @value = ''
    end
  end

end
