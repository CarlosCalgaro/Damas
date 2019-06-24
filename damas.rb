require_relative "tabuleiro"
require_relative "util/input_parser"
require_relative "core/jogada_manager"

tabuleiro = Tabuleiro.new
doExit = 0
jogada_manager = JogadaManager.new(tabuleiro)

i = 0
while(i < 10)
    system "clear" or system "cls"
    tabuleiro.draw
    source = nil
    destination = nil 
    while(source.nil?)
        puts "Qual peça deseja jogar?"
        source = InputParser.parse(gets.chomp)
        #source = InputParser.parse("C0")
    end
    while(destination.nil?)
        puts "Para onde deseja jogar?"
        destination = InputParser.parse(gets.chomp)
        #destination = InputParser.parse("D1")
    end
    # # tabuleiro.mover(destination, source)
    tabuleiro.mover(destination, source)
    puts "ENTER PARA CONTINUAR"
    gets.chomp
    i = i +1
end