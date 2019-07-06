require_relative "../damas_multiplayer"

RSpec.describe DamasMultiplayer, "" do
    context "Game loop" do 
        it "should start and end games" do 
            DamasMultiplayer::end_game()
            time1 = DamasMultiplayer::join_game()
            time2 = DamasMultiplayer::join_game()
            expect(time1).to eq(:time1)
            expect(time2).to eq(:time2)
            expect(DamasMultiplayer::end_game()).to eq(true)
        end
       
        it "should raise error when the game is full" do 
            DamasMultiplayer::join_game()
            DamasMultiplayer::join_game()
            expect{DamasMultiplayer::join_game()}.to raise_error(GameIsFullError)
            expect{DamasMultiplayer::join_game()}.to raise_error(GameIsFullError)
            expect{DamasMultiplayer::join_game()}.to raise_error(GameIsFullError)
        end
        
        it "should set and get correct winner" do 
            DamasMultiplayer::end_game()
            DamasMultiplayer::join_game()
            DamasMultiplayer::join_game()
            expect{DamasMultiplayer::set_winner(:time1)}.not_to raise_error()
            expect(DamasMultiplayer::get_winner()).to eq(:time1)
            expect{DamasMultiplayer::set_winner(:time2)}.not_to raise_error()
            expect(DamasMultiplayer::get_winner()).to eq(:time2)
            
        end
    end
end