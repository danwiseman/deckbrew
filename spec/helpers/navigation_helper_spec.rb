require "rails_helper"
require_relative "../../app/helpers/master_decks_helper"

describe NavigationHelper do

  include MasterDecksHelper
  

  
  describe "#breadcrumbs" do
    
    it "returns a link to the user profile when just a user is passed" do 
       user = FactoryBot.create(:user)
       expect(breadcrumbs(user)).to have_text(user.username)  
    end
    it "returns links to the user profile and the deck when a user and masterdeck are passed" do
        master_deck = FactoryBot.create(:master_deck)
        #expected_args=nil
        #allow(helper).to receive(helper.master_deck_with_privacy_badge).with(master_deck, false)
        
        expect(breadcrumbs(master_deck.user, master_deck)).to have_text(master_deck.name)
    end
    it "returns links to the user profile, the deck, and a branch when all three are passed" do
      branch = FactoryBot.create(:branch)
      #expect(helper).to receive(helper.master_deck_with_privacy_badge).with(branch.master_deck)
      
      expect(breadcrumbs(branch.master_deck.user, branch.master_deck, branch)).to have_text(branch.name)
    end
 
  end
  
  describe "#navbar_signed_in_user_dropdown" do
    
    let(:user) { FactoryBot.create(:slugged_user) }
    
    it "shows the current user dropdown menu when logged in" do
      

      allow(helper).to receive(:current_user).and_return(user)
      
      expect(helper.navbar_signed_in_user_dropdown).to have_text("Profile")
    end
  end
  
  describe "#navbar_no_user_dropdown" do
    
    it "shows the login and sign up menu when not logged in" do
      

      expect(navbar_no_user_dropdown).to have_text("Sign In")
    
   end
    
  end
  
  
end