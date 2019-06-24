class OffBoardError < StandardError

    def initialize(pos, msg = "Fora do Tabuleiro")
        @pos = pos
        super("#{msg}: #{pos}")
    end
    
end