require 'rails_helper'

RSpec.describe Branch, type: :model do
    
    before(:each) do
        @md = FactoryBot.create(:master_deck)
    end
    
    it "is valid with valid attributes" do
        br = Branch.new(name: "new branch", master_deck: @md, branched_from: 0, branched_from_deck: 0)
        expect(br).to be_valid
    end
    
    it "is not valid without a name" do 
        br = Branch.new(name: nil, master_deck: @md, branched_from: 0, branched_from_deck: 0)
        expect(br).to_not be_valid
    end
    it "is not valid without a master_deck" do 
        br = Branch.new(name: "new branch", master_deck: nil, branched_from: 0, branched_from_deck: 0)
        expect(br).to_not be_valid
    end

    it "is not valid without a branched_from" do
        br = Branch.new(name: "new branch", master_deck: @md, branched_from: nil, branched_from_deck: 0)
        expect(br).to_not be_valid
    end
    
    it "is not valid without a branched_from_deck" do 
        br = Branch.new(name: "new branch", master_deck: @md, branched_from: 0, branched_from_deck: nil)
        expect(br).to_not be_valid
    end
  
end
