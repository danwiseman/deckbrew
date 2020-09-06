require 'rails_helper'
require 'request_helper'

require_relative '../support/branch_helpers'
require_relative '../support/master_deck_helpers'
require_relative '../support/user_helpers'

include UserHelpers
include MasterDeckHelpers
include BranchHelpers


RSpec.describe "Decks", type: :request do
    
    
    it "should show all the cards from the chosen deck"
    
    it "should add chosen cards to the deck" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        
        visit "/decks/#{master_deck.slug}/branch/main/edit/cards"
        
        fill_in "card name", with => "Steppe Glider"
        click_button ("add card")
        
        expect("#card_list").to have_text("Steppe Glider")
        
        click_button "Save"
        
        expect(page).to have_text("Steppe Glider")
        
    end
    
    it "should remove chosen cards from the deck"
    
    it "should save a history, by creating a new head deck, of changes to the deck"
    
    it "should show differences between two decks"
    
    
    

end
