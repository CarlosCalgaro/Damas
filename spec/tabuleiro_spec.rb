require_relative "../tabuleiro.rb"

RSpec.describe Tabuleiro, "#valid_pos" do
    context "All possiblities" do 
        it "Should display if position is valid" do 
            tabuleiro = Tabuleiro.new
            expect(tabuleiro.valid_pos([0,7])).to eq(true)
            expect(tabuleiro.valid_pos([-2,5])).to eq(true)
            expect(tabuleiro.valid_pos([2,17])).to eq(true)
        end
    end
end