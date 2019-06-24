class JogadaManager

    attr_accessor :tabuleiro
    attr_reader :jogadas

    @jogadas = []
    
    def initialize(tabuleiro)
        self.tabuleiro = tabuleiro.grid
        @jogadas = []
    end
    

    def verificar_jogadas(source, time)
        throw RuntimeError.new("Favor enviar array de 2") unless source.is_a?(Array) && source.length == 2
        x = source[0]
        y = source[1]
    
        if(time == :time1)
            if((x+1 < Tabuleiro::LENGTH && x+1 > 0) && (y+1 < Tabuleiro::LENGTH && y+1 > 0))
                x = x + 1
                y = y + 1
                if(self.tabuleiro[x][y].nil?)
                    arr = [x, y]
                    @jogadas.push(arr)
                elsif(self.tabuleiro[x][y].time == :time2)
                    x = x + 1
                    y = y + 1
                    if(self.tabuleiro[x][y].nil?)
                        arr = [x, y]
                        @jogadas.push(arr)
                    end
                end
            elsif((x-1 < Tabuleiro::LENGTH && x-1 > 0 ) && (y+1 < Tabuleiro::LENGTH && y+1 > 0))
                x = x - 1
                y = y + 1
                if(self.tabuleiro[x][y].nil?)
                    arr = [x, y]
                    @jogadas.push(arr)
                
                end
            end
        end

    end



end