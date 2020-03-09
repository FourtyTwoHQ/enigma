module Enigma

  class Category
    attr_reader :id
    attr_reader :items

    def initialize(hash: Hash)
      @id = hash['id']
      @items = hash['items']
    end
  end

end
