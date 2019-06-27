require 'rubygems'
require 'bundler/setup'
require_relative 'peca'
require_relative 'errors/off_board_error'

Bundler.require(:default)

class Tabuleiro 

    LENGTH = 8
    attr_accessor :grid


    def initialize(new_game: true)
        @grid = Array.new(8){Array.new(8)}
        new_game() if new_game
    end


    def draw 
        letters = ('A'..'H').to_a
        ('0'..'7').to_a.each{|num| print"\t#{num}"}
        @grid.each_with_index do |coluna, index|
            print "\n#{letters[index]}#{index}\t"
            coluna.each do |casa|
                if casa == nil 
                    print "-\t"
                else
                    print "#{casa.render}\t"
                end
            end
            puts ""
        end
    end
    
    def []=(pos, peca)
        raise OffBoardError unless valid_pos?(pos)
        x, y = pos
        @grid[x][y] = peca
    end

    def [](pos)
        raise OffBoardError.new(pos) unless valid_pos? pos
        x,y = pos
        return @grid[x][y]
    end
    
    def place_piece(piece, pos)
        x, y = pos
        @grid[x][y] = piece
    end

    def remove_piece(pos)
        x, y = pos
        @grid[x][y] = nil
    end

    def valid_pos?(pos)
        pos.all?{|pos| (pos >= 0 && pos < Tabuleiro::LENGTH)}
    end
    
    def has_enemy_piece?(pos, time)
        raise new OffBoardError(pos) unless valid_pos?(pos)
        x, y = pos
        if(!grid_empty?(pos) && (self[pos].time != time))
            return true
        else 
            return false
        end
    end
    
    def grid_empty?(pos)
        return @grid[pos[0]][pos[1]].nil?
    end
    
    def dup
        test_board = Tabuleiro.new(false)
        @grid.each_index do |row|
          @grid[row].each_with_index do |piece, col|
            pos = [row,col]
            piece = self[pos]
            test_board[pos] = piece ? piece.dup(test_board) : nil
          end
        end
    
        test_board
      end

    private

    def new_game
    
        (0..2).each do |x|
            (0..7).each do |y|
                if(x == 1)
                    @grid[x][y] = Peca.new(self, :time1, [x ,y]) if y.odd?
                else
                    @grid[x][y] = Peca.new(self, :time1, [x ,y]) if y.even?
                end
            end
        end

        (5..7).each do |x|
            (0..7).each do |y|
                if(x == 6)
                    @grid[x][y] = Peca.new(self, :time2, [x ,y]) if y.even?
                else
                    @grid[x][y] = Peca.new(self, :time2, [x ,y]) if y.odd?
                end
            end
        end
    end

    public

    def tile_between_pos(src, dest)
        ((Vector.elements(src) + Vector.elements(dest)) / 2).to_a
    end

    def mover(destination, source)
        x, y = source
        peca = @grid[x][y]
        begin
            puts "Jogando de: #{source} para: #{destination}"
            peca.make_move(destination)
        rescue InvalidMoveError => e
            puts e
            return false
        end
        return true
    end

end
