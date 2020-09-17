require "rails_helper"

describe MasterDecksHelper do

    describe "#PathToMasterDeck" do
        it "returns a link to the master deck's view page" do
            
            master_deck = FactoryBot.create(:master_deck)
            
            expect(MasterDecksHelper.PathToMasterDeck(master_deck)).to eq('/u/' + master_deck.user.slug + '/decks/' +  master_deck.slug)
        end
        
        it "returns a link to just the deck for deck administration purposes" do
            master_deck = FactoryBot.create(:master_deck)
            
            expect(MasterDecksHelper.PathToMasterDeck(master_deck, admin_path: true)).to eq('/decks/' +  master_deck.slug)
            
        end
    end
    
    describe "#master_deck_with_privacy_badge" do
        it "returns a link to the master deck with a public badge" do
            master_deck = FactoryBot.create(:master_deck)
            expect(master_deck_with_privacy_badge(master_deck, true)).to have_text(master_deck.name + " Public")
        end
        
        it "returns a link to the master deck with a private badge when it is private" do
            
            master_deck = FactoryBot.create(:master_deck, is_public: 'false')
            expect(master_deck_with_privacy_badge(master_deck, true)).to have_text(master_deck.name + " Private")
        end
        
    end
    
    

end