class InputParser

    def self.parse(str)
        return nil unless str.length == 2
        str.upcase!
        ascii = str.codepoints
        ascii[0] = ascii[0] - 65
        ascii[1] = ascii[1] - 48        
        return ascii
    end

    def self.to_coordinate(arr)
        return nil unless arr.length == 2
        range = "A".."H"
        return [ range.to_a[arr[0]], arr[1]]
    end
end