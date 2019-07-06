require_relative "tabuleiro"
require_relative "util/input_parser"
require_relative "damas_multiplayer"
require_relative "game"
require_relative "beautify"
game = Game.new

beautify = Beautify.new(game)
#Trata o crtl+c do terminal
trap "SIGINT" do
    DamasMultiplayer::end_game()
    puts "\nJogo finalizado"
    exit 130
end

puts beautify.waiting_player
sleep(1) while( game.player_count < 2)

move = nil

while(game.winner.nil?)
    beautify.clear_screen
    if(!game.is_your_turn?)
        beautify.write_board
        print "Aguardando outro jogador: "
        while(!game.is_your_turn? && game.winner.nil?)    
            print  "."
            sleep(1)
        end
    end
    beautify.clear_screen
    break unless (game.winner.nil?)
    game.sync(move)
    beautify.write_board
# Lê jogadas
    source = nil
    destination = nil 
    while(source.nil?)
        puts "Qual peça deseja jogar? #{beautify.possible_plays}"
        source = InputParser.parse(gets.chomp)
        source = nil unless (!source.nil? && game.team_pieces_moves.include?(source))
    end
    valid_moves = game.board[source].nil? ? [] : game.board[source].valid_moves 
    while(destination.nil?)
        puts "Movimentos Validos sao: #{valid_moves.collect{|e| InputParser.to_coordinate(e)}}"
        puts "Para onde deseja jogar?"
        destination = InputParser.parse(gets.chomp)
    end
    begin 
      move =  game.mover(destination, source)
    rescue PlayError => e 
        puts e
    end

    puts "ENTER PARA CONTINUAR"
    gets.chomp
end

puts "#{beautify.time} GANHOU O JOGO"



