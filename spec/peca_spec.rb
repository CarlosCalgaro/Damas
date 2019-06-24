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
            # expect{peca.make_simple_move([5,1])}.to raise_error
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
            time2 = [[5,1], [5, 3]]
            time1 = [[4, 2], [4, 4], [2, 4], [2, 2]]

            tabuleiro = Tabuleiro.new(new_game: false)
            time1.each do |pos| 
                tabuleiro[pos] = Peca.new(tabuleiro, :time1, pos)
            end
            time2.each do |pos|   
                tabuleiro[pos] = Peca.new(tabuleiro, :time2, pos)
            end

        end

        it "should return adjascent tiles" do 
            time1 = [[6,1], [5, 2]]
            time2 = [[6,3]]

            tabuleiro = Tabuleiro.new(new_game: false)
            time1.each do |pos| 
                tabuleiro[pos] = Peca.new(tabuleiro, :time1, pos)
            end
            time2.each do |pos|   
                tabuleiro[pos] = Peca.new(tabuleiro, :time2, pos)
            end
            peca = tabuleiro[time1.first]
            peca2 = tabuleiro[time2.first]
            
            tabuleiro.draw
            expect(peca.adjascent_tiles).to eq([[7,2], [7,0]])
            expect(peca2.adjascent_tiles).to eq([[5,4], [5,2]])
        end


        # it "should promote piece" do 
        #     time2 = [[6,1], [5, 2]]
        #     time1 = [[6,3]]

        #     tabuleiro = Tabuleiro.new(new_game: false)
        #     time1.each do |pos| 
        #         tabuleiro[pos] = Peca.new(tabuleiro, :time1, pos)
        #     end
        #     time2.each do |pos|   
        #         tabuleiro[pos] = Peca.new(tabuleiro, :time2, pos)
        #     end
        #     tabuleiro.draw
        #     expect(peca.jump_moves).to eq([[3,3]])
        #     expect(peca2.jump_moves).to(eq([[3, 5], [3,1]]))
        # end



    end
end
