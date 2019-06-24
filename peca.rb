require 'matrix'
require_relative 'errors/invalid_move_error'
require_relative 'errors/invalid_time_error'

class Peca

    attr_accessor :time, :tipo, :valid_jump_moves
    attr_reader :pos

    MOVE_DIFFS = {
        simple: {
            time1: [[1, 1], [1, -1]],
            time2: [[-1,1], [-1, -1]]
        }
    }

    
    def initialize(board, time, pos)

        @valid_jump_moves = [ ]
        @board = board
        @time = time
        @tipo = :pawn
        @pos = pos
    end


    def valid_moves
        jump_moves.empty? ? simple_moves : jump_moves
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

    def jump_moves(pos = @pos, moves = [])
        valid_moves = []
        diffs = MOVE_DIFFS[:simple][@time.to_sym]
        diffs.each do |move|
            new_pos = (Vector.elements(pos) + Vector.elements(move)).to_a
            if(@board.valid_pos?(new_pos))
                if(@board.has_enemy_piece?(new_pos, @time))
                    new_pos = (Vector.elements(new_pos) + Vector.elements(move)).to_a
                    if(@board.valid_pos?(new_pos) && @board.grid_empty?(new_pos))
                        valid_moves.push new_pos
                    end
                end        
            end
        end
        return valid_moves
    end

    # def jump_moves(pos = @pos, moves = [])
        
    #     diffs = MOVE_DIFFS[:simple][@time.to_sym]
    #     diffs.each do |move|
    #         new_pos = (Vector.elements(pos) + Vector.elements(move)).to_a
    #         #binding.pry if(pos == [3, 3])
    #         if(@board.valid_pos?(new_pos))
    #             if(@board.has_enemy_piece?(new_pos, @time))
    #                 new_pos = (Vector.elements(new_pos) + Vector.elements(move)).to_a
    #                 if(@board.valid_pos?(new_pos) && @board.grid_empty?(new_pos))
    #                     # Aqui ocorre 1 pulo !!!!
    #                     jump_moves(new_pos, moves)
    #                 end
    #             else
    #                 moves.push(new_pos)
    #                 return moves
    #             end
    #         end
    #     end
    # end

    def is_same_time?(piece)
        return piece.same_time? @time
    end

    def make_move(pos)
        make_simple_move(pos) if !make_jump_move(pos)
    end
    
    def make_simple_move(pos)
        return false unless self.valid_move? pos
        @board.remove_piece(@pos)
        @pos = pos
        @board.place_piece(self, pos)
        promote if (promotable? && !promoted)
    end
    
    def make_jump_move(pos)
        
        return false unless valid_move?(pos)
        @board.remove_piece(@pos)
        @board.remove_piece(@board.tile_between_pos(@pos, pos))
        @board.place_piece(self, pos)
        @pos = pos
        promote if promotable? && !promoted?
        true
    end

    def same_time?(time)
        raise InvalidTimeError.new(time) unless [:time1, :time2].include? time
        return time == @time
    end
    
    def tile_between_pos()
        diffs = MOVE_DIFFS[:simple][@time.to_sym]
        return diffs.collect{|e| (Vector.elements(e) + Vector.elements(pos)).to_a}
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
        if(@time == :time1)
            return (@pos.first == 7)
        else
            return (@pos.first == 0)
        end
    end

end