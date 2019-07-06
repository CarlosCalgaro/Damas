require_relative "../tabuleiro"

RSpec.describe Tabuleiro, "Tabuleiro" do
    context "All possiblities" do 
        it "Should display if position is valid" do 
            tabuleiro = Tabuleiro.new
            expect(tabuleiro.valid_pos?([0,7])).to eq(true)
            expect(tabuleiro.valid_pos?([-2,5])).to eq(false)
            expect(tabuleiro.valid_pos?([2,17])).to eq(false)
        end
    end

    context "#pieces_count?" do 
        it "Should show pieces count for time" do 
            time2 = [[1, 2], [5, 3]]
            time1 = [[6, 2], [4, 4], [2, 4], [2, 2]]
            tabuleiro = Tabuleiro.new(new_game: false)
            time1.each do |pos| 
                tabuleiro[pos] = Peca.new(tabuleiro, :time1, pos)
            end
            time2.each do |pos|   
                tabuleiro[pos] = Peca.new(tabuleiro, :time2, pos)
            end

            expect(tabuleiro.pieces_count?(:time1)).to eq(4)
            expect(tabuleiro.pieces_count?(:time2)).to eq(2)
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

    context "#serialize" do 
        it "should retrieve the correct state of the board" do 
            tabuleiro = Tabuleiro.new
            string = tabuleiro.serialize
            tabuleiro2 = Tabuleiro.load(string)
            expect(tabuleiro).to eq(tabuleiro)
        end

        it "should retrieve the correct state of the board even if piece moved" do 
            tabuleiro = Tabuleiro.new
            tabuleiro.mover([3,1] , [2,0])
            string = tabuleiro.serialize
            tabuleiro2 = Tabuleiro.load(string)
            expect(tabuleiro).to eq(tabuleiro)
        end

    end


end