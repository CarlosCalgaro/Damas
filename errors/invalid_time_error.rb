class InvalidTimeError < StandardError

    def initialize(pos, msg = "Time inválido")
        @pos = pos
        super("#{msg}: #{pos}")
    end
    
end