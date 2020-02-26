module Enigma

    class Categories
        attr_reader :id
        attr_reader :items

        def initialize(cateogiroes: Array)
            @id    = hash['id']
            @items = hash['items']
        end
    end

end