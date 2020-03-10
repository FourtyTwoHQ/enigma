module Enigma

  class Secret
    attr_reader :name
    attr_accessor :items

    def initialize(hash: Hash)
      @name = hash[:name]
      @items = hash[:items]
    end
  end

end
