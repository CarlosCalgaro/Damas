require_relative "../tabuleiro.rb"

RSpec.describe Tabuleiro, "Tabuleiro" do
    context "All possiblities" do 
        it "Should display if position is valid" do 
            tabuleiro = Tabuleiro.new
            expect(tabuleiro.valid_pos?([0,7])).to eq(true)
            expect(tabuleiro.valid_pos?([-2,5])).to eq(false)
            expect(tabuleiro.valid_pos?([2,17])).to eq(false)
        end
    end


    context "#has_enemy_piece" do 
        it "Should display if has enemy piece in position" do 
            tabuleiro = Tabuleiro.new
            pos = [5,1]
            expect(tabuleiro.has_enemy_piece?(pos, :time1)).to eq(true)
            expect(tabuleiro.has_enemy_piece?(pos, :time2)).to eq(false)
            pos =[2, 2]
            expect(tabuleiro.has_enemy_piece?(pos, :time2)).to eq(true)
            expect(tabuleiro.has_enemy_piece?(pos, :time1)).to eq(false)
        end
    end

    context "#initialize" do 
        it "Should not populate if new_game = false" do 
            tabuleiro = Tabuleiro.new(new_game: false)
            pos = [0, 0]
            expect(tabuleiro[pos]).to eq(nil)
        end
    end


end