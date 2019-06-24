require_relative "../core/jogada_manager"
require_relative "../tabuleiro"


RSpec.describe JogadaManager, "#jogadas_possiveis" do
    context "Initial pieces" do 
        it "Should display possible plays" do 
            tabuleiro = Tabuleiro.new
            jogada_manager = JogadaManager.new(tabuleiro)
            jogada_manager.verificar_jogadas([2,0], :time1)
            expect(jogada_manager.jogadas).to eq([[3,1]])
        end
    end
end