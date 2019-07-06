require 'rubygems'
require 'bundler/setup'
require 'zlib'
require_relative 'errors/game_is_full_error'
require_relative "errors/driver_error"
Bundler.require(:default)

class DamasMultiplayer 

    module Multiplayer
        extend FFI::Library
        ffi_lib 'integration/integration.so'
        attach_function :execute_ioctl, [], :int
        attach_function :join_game, [], :int
        attach_function :end_game, [], :int
        attach_function :get_current_turn, [], :int
        attach_function :get_player_count, [], :int
        attach_function :change_turn, [], :int
        attach_function :get_plays_count, [], :int
        attach_function :get_winner, [], :int
        attach_function :set_winner, [:int], :int
    end
    
    PATH = "/dev/damas"

    def self.player_count 
        return Multiplayer::get_player_count()
    end

    def self.plays_count
        return Multiplayer::get_plays_count()
    end
    
    def self.change_turn 
        return Multiplayer::change_turn()
    end
    
    def self.join_game
        time = Multiplayer::join_game()
        raise GameIsFullError.new() unless time != -1
        return (time == 1) ? :time1 : :time2
    end

    def self.set_winner(time) 
        raise RuntimeError.new("Time nao Existe!!!!") unless [:time1, :time2].include? time
        Multiplayer::set_winner((time == :time1) ? 1 : 2)
    end
    
    def self.get_winner
        winner  = Multiplayer::get_winner
        case winner
        when 1
            return :time1
        when 2
            return :time2
        else 
            return nil
        end
    end
    
    def self.end_game
        ret = Multiplayer::end_game()
        return (ret == -1) ? false : true
    end
    
    def self.dump_board(board)
        #return File.write(PATH, Zlib.deflate(board.serialize))
        File.write(PATH, "")
        return File.write(PATH, board.serialize)
    end

    def self.current_turn 
        turn = Multiplayer::get_current_turn();
        case turn 
        when 1
            return :time1
        when 2
            return :time2
        when 0 
            raise DriverError.new 
        end
    end

    def self.load_board
        #return Tabuleiro.load(Zlib.inflate(File.read(PATH)))
        return Tabuleiro.load(File.read(PATH))
    end
end


