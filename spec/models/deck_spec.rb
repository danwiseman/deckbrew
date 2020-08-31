require 'rails_helper'

RSpec.describe Deck, type: :model do
    
    before(:each) do
        @br = FactoryBot.create(:branch)
    end
      
    it "is valid with valid attributes" do
        d = Deck.new(previousversion: 1, version: 3, branch: @br)
        expect(d).to be_valid
    end
    
    it "is not valid without a branch" do
        d = Deck.new(branch: nil, previousversion: 0, version: 0)
        expect(d).to_not be_valid
    end
    
    it "is not valid without a version" do 
        d = Deck.new(version: nil, previousversion: 3, branch: @br)
        expect(d).to_not be_valid
    end
    
    it "is not valid without a previousversion" do
        d = Deck.new(previousversion: nil, version: 3, branch: @br)
        expect(d).to_not be_valid
    end
    
    
end
