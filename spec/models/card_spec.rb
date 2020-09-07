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
    

  
  
end
