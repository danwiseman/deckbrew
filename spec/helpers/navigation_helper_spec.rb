require "rails_helper"

describe NavigationHelper do
  describe "#breadcrumbs" do
    
    it "returns a link to the user profile when just a user is passed" do 
       user = FactoryBot.create(:user)
       expect(breadcrumbs(user)).to have_text(user.username)  
    end
    it "returns links to the user profile and the deck when a user and masterdeck are passed" do
        master_deck = FactoryBot.create(:master_deck)
        expect(breadcrumbs(master_deck.user, master_deck)).to have_text(master_deck.name)
    end
    it "returns links to the user profile, the deck, and a branch when all three are passed" do
      branch = FactoryBot.create(:branch)
      expect(breadcrumbs(branch.master_deck.user, branch.master_deck, branch)).to have_text(branch.name)
    end
 
  end
  
  
end