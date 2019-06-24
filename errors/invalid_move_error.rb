class InvalidMoveError < StandardError

    def initialize(pos, msg = "Movimento inválido")
        @pos = pos
        super("#{msg}: #{pos}")
    end
    
end