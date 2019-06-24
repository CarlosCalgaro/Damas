class InputParser


    # attr_accessor :jogada;
    # def initialize(str)
    #     self.jogada = parse(str.upcase)
    # end

    def self.parse(str)
        return nil unless str.length == 2
        str.upcase!
        ascii = str.codepoints
        ascii[0] = ascii[0] - 65
        ascii[1] = ascii[1] - 48        
        return ascii
    end
end