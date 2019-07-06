class GameIsFullError < StandardError

    def initialize(msg = "Jogo já esta cheio")
        super("Jogo ja está cheio")
    end
    
end