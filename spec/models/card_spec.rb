require 'rails_helper'

RSpec.describe Card, type: :model do
  
  it "is valid with valid attributes" do
        c = Card.new(oracle_name: Faker::Book.title, scryfall_id: Faker::Internet.uuid, scryfall_data: '{}')
        expect(c).to be_valid
    end
    
    it "is not valid without an oracle_name" do
        c = Card.new(oracle_name: nil, scryfall_id: Faker::Internet.uuid, scryfall_data: '{}')
        expect(c).to_not be_valid
    end
    
    it "is not valid without a scryfall_id" do 
        c = Card.new(oracle_name: Faker::Book.title, scryfall_id: nil, scryfall_data: '{}')
        expect(c).to_not be_valid
    end
    
    it "can grab a card if it doesn't exist or return nil if it isn't a card" do
        c = Card.snatch(uuid: 'fc4d7aa2-ee1b-435c-8876-44111fafc97a')    
        expect(c.oracle_name).to eq("Oros, the Avenger") 
        
        ac = Card.snatch(name: 'Austere Command')    
        expect(ac.oracle_name).to eq("Austere Command") 
        
        
        rc = Card.snatch(name: 'Roon of the Hidden Realm', set: 'cma')    
        expect(rc.scryfall_id).to eq("f8ff4b08-fa1a-4564-b427-ea89e54a0e7b") 
        
        bad_c = Card.snatch(name: 'Bill Murray')
        expect(bad_c).to be(nil)
        
    end
    
  
  
end
