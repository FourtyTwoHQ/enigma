module Enigma

  class Secret
    attr_reader :name
    attr_accessor :items

    def initialize(hash: Hash)
      hash = hash.transform_keys(&:to_sym)
      @name = hash[:name]
      @items = hash[:items]
    end
  end

end
