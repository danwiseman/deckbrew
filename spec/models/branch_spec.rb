require 'rails_helper'

RSpec.describe Branch, type: :model do
    
    before(:each) do
        @md = FactoryBot.create(:master_deck)
    end
    
    it "is valid with valid attributes" do
        br = Branch.new(name: "new branch", master_deck: @md)
        expect(br).to be_valid
    end
    
    it "is not valid without a name" do 
        br = Branch.new(name: nil)
        expect(br).to_not be_valid
    end
    it "is not valid without a master_deck" do 
        br = Branch.new(master_deck: nil)
        expect(br).to_not be_valid
    end

    it "is not valid without a head_deck"
    it "is not valid without a branched_from"
    it "is not valid without a branched_from_deck"
  
end
