require_relative "../tabuleiro.rb"

RSpec.describe Peca, "#simple_moves" do
    context "Valid moves" do 
        it "Should display if position is valid" do 
            tabuleiro = Tabuleiro.new

            expect(tabuleiro.grid[0][0].valid_moves).to eq([])
            expect(tabuleiro.grid[2][0].valid_moves).to eq([[3,1]])
        end

        it "should make valid moves" do 
            tabuleiro = Tabuleiro.new
            peca = tabuleiro.grid[2][0]
            expect{peca.make_simple_move([3,1])}.to_not raise_error
            expect{peca.make_simple_move([4,2])}.to_not raise_error
            expect{peca.make_simple_move([5,1])}.to raise_error
        end
        
        it "should make this sequence of moves" do 
            tabuleiro = Tabuleiro.new
            peca = tabuleiro.grid[2][0]
            peca.make_simple_move([3,1])
            peca.make_simple_move([4,0])
            expect(peca.pos).to eq([4,0])
        end
        
        
        it "should make valid jumps" do 
            tabuleiro = Tabuleiro.new
            peca = tabuleiro.grid[2][0]
            #expect(peca.jump_moves).to eq([2,0])
            #expect(peca.jump_moves([3,1])).to eq([3,1])
        end

        it "should return valid jumps moves" do 
            tabuleiro = Tabuleiro.new
            peca = tabuleiro.grid[2][0]
            peca2 = tabuleiro.grid[5][1]
            peca.make_simple_move([3,1])
            peca.make_simple_move([4,2])
            peca2.next_valid_jump
            binding.pry
            # expect().to eq(true)
        end
    end
end
