require_relative "errors/play_error"

class Game

    attr_accessor :time, :board

    def initialize()
        @board = Tabuleiro.new
        @time = attribute_team()
        @new_game = true
    end

    def opposite_time(time)
        raise RuntimerError.new() unless [:time1, :time2].include? time
        (time == :time1) ? :time2 : :time1 
    end

    def mover(destination, source)
        raise PlayError.new("Não é seu turno") unless is_your_turn?
        raise PlayError.new("Coordenada selecionada esta fora do tabuleiro") if(!@board.valid_pos?(destination) || !@board.valid_pos?(source))
        raise PlayError.new("Nenhuma peça selecionada") if @board[source].nil?
        raise PlayError.new("Precisa jogar com peças do seu time")  if @board[source].time != @time
        move = @board.mover(destination, source)
        case move 
        when :simple_move, :promotion
            send_play
        when :win
            DamasMultiplayer::set_winner(@time)
        when :error
            raise PlayError.new("Movimento Invalido!")
        end      
        return move      
    end

    def is_your_turn?
        current_turn == @time
    end

    def current_turn 
        DamasMultiplayer::current_turn
    end
    
    def sync(move)
        return if(DamasMultiplayer::plays_count == 0)
        return if(move == :jump_move)
        @board = DamasMultiplayer::load_board
    end

    def send_play
        DamasMultiplayer::dump_board(self.board)
        DamasMultiplayer::change_turn()
    end
    
    def winner
        return DamasMultiplayer::get_winner()
    end

    def turn_count
        return DamasMultiplayer::plays_count()
    end
    
    def player_count
        return DamasMultiplayer::player_count
    end
    
    def attribute_team
        begin
            return DamasMultiplayer::join_game()
        rescue GameIsFullError => e 
            DamasMultiplayer::end_game()
            return DamasMultiplayer::join_game()
        end        
    end

    def team_pieces 
        pieces = []
        @board.grid.each do |e|
            a = e.select{|e| !e.nil? && e.time == @time}.each{|e| pieces.push(e)}
        end
        return pieces
    end
    
    def team_pieces_moves
        possible_moves.collect{|e| e.pos}
    end

    def possible_moves
        pieces_with_move = team_pieces.select{|e| !e.valid_moves.empty?}
        pieces_with_jump = team_pieces.select{|e| !e.jump_moves.empty?}
        pieces_with_jump.empty? ? pieces_with_move : pieces_with_jump
    end

    def test
    binding.pry
    end
end