
require_relative "damas_multiplayer"
require_relative "util/input_parser"
class Beautify


    def initialize(game)
        @game = game
    end

    
    def time()
        case @game.time
        when :time1
            return "Time 1"
        when :time2 
            return "Time 2"
        else 
            return nil
        end
    end

    def clear_screen
        system "clear" or system "cls"
    end
   
    def possible_plays
       return @game.team_pieces_moves.collect{|e| InputParser.to_coordinate(e)}
    end
    
    def waiting_player
        return "Buscando Partida!! Encontrado #{@game.player_count} de 2 jogadores"
    end
    
    def write_board()
        puts board_header()
        @game.board.draw
    end
    private
     
    def board_header()
        return "Seu time: #{@game.time} --- Agora joga: #{@game.current_turn} -- Numero de Jogadas: #{@game.turn_count}"
    end
end