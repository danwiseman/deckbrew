require 'rails_helper'

RSpec.describe MasterDeck, type: :model do
    
   
    it "is valid with valid attributes" do
        md = FactoryBot.create(:master_deck)
        expect(md).to be_valid
    end
    
    it "is not valid without a name" do 
        md = MasterDeck.new(name: nil)
        expect(md).to_not be_valid
    end
    it "is not valid without a user" do 
        md = MasterDeck.new(user: nil)
        expect(md).to_not be_valid
    end
    it "is not valid without a deck_type" do 
        md = MasterDeck.new(deck_type: nil)
        expect(md).to_not be_valid
    end
    it "is not valid without an is_public" do 
        md = MasterDeck.new(is_public: nil)
        expect(md).to_not be_valid
    end
    
    it "is not valid if another deck from the same user has the same name" do
       md = FactoryBot.create(:master_deck)
       md2 = MasterDeck.new(name: md.name, user: md.user, deck_type: md.deck_type, is_public: md.is_public)
       
       expect(md2).to_not be_valid 
    end
    
    it "is valid if a different user inputs the same deck name" do
       md = FactoryBot.create(:master_deck)
       md2 = MasterDeck.new(name: md.name, user: FactoryBot.create(:user), deck_type: md.deck_type, is_public: md.is_public)
       
       expect(md2).to be_valid 
        
    end
  
end
