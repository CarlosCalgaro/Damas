require 'matrix'
require_relative 'errors/invalid_move_error'
require_relative 'errors/invalid_time_error'

class Peca

    attr_accessor :time, :tipo
    attr_reader :pos

    MOVE_DIFFS = {
        simple: {
            time1: [[1, 1], [1, -1]],
            time2: [[-1,1], [-1, 1]]
        },
        jump: {
            time1: [[2, 1], [2, -1]],
            time2: [[-2,1], [-2, 1]]
        }
    }
    def initialize(board, time, pos)
        @board = board
        @time = time
        @tipo = :pawn
        @pos = pos
    end


    def valid_moves
        simple_moves
    end

    def valid_move?(destination)
        return valid_moves.include?(destination)
    end
    
    public
    def simple_moves
        valid_moves = []
        diffs = MOVE_DIFFS[:simple][@time.to_sym]
        diffs.each do |move| 
            new_pos = Vector.elements(@pos) + Vector.elements(move)
            if(@board.valid_pos?(new_pos) && @board.grid_empty?(new_pos))
                valid_moves.push(new_pos.to_a)
            end
        end
        return valid_moves
    end


    def dup(board)
        new_piece = Piece.new(board, color, pos)
        new_piece.promote if promoted?
        new_piece
    end

    def has_enemy_piece?(pos)
        raise OffBoardError unless @board.valid_pos? pos
        if(!@board.grid_empty?(pos))
            return is_same_time?(@board[pos])
        else
            return false
        end
    end

    def is_same_time?(piece)
        return piece.same_time? @time
    end

    def make_simple_move(pos)
        raise InvalidMoveError.new(pos) unless self.valid_move?(pos)
        @board.remove_piece(@pos)
        @pos = pos
        x, y = pos
        @board.place_piece(self, pos)
        promote if (promotable? && !promoted)
    end
    
    
    def same_time?(time)
        raise InvalidTimeError.new(time) unless [:time1, :time2].include? time
        return time == @time
    end
    
    public
    def render 
        if(@tipo == :queen)
            @time == :time1 ? "X" : "0"
        else
            @time == :time1 ? "x" : "o"
        end
    end
    
    def promoted? 
        return @tipo == :queen
    end

    def promote
        @tipo = :queen
    end

    def promotable?
        row = @pos.first
        return @time == :time1 ? (row == 0) : (row == 7)
    end

end