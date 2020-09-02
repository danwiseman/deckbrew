require "rails_helper"

describe MasterDecksHelper do

    describe "#PathToMasterDeck" do
        it "returns a link to the master deck's view page" do
            
            master_deck = FactoryBot.create(:master_deck)
            
            expect(MasterDecksHelper.PathToMasterDeck(master_deck)).to eq('/u/' + master_deck.user.slug + '/decks/' +  master_deck.slug)
        end
    end

end