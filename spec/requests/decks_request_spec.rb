require 'rails_helper'
require 'request_helper'

require_relative '../support/branch_helpers'
require_relative '../support/master_deck_helpers'
require_relative '../support/user_helpers'

include UserHelpers
include MasterDeckHelpers
include BranchHelpers


RSpec.describe "Decks", type: :request do
    
    
        
    
    it "should add chosen cards to the deck and then show them", :js => true do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        
        visit "/decks/#{master_deck.slug}/branch/main/editcards"
        page.evaluate_script 'jQuery.active == 0'
        
        fill_in "new-card-name", :with => "Steppe Glider"
        page.evaluate_script 'jQuery.active == 0'
        
        page.execute_script("$('#addCardBtn').trigger('click')")
        

        expect(page).to have_css("#card-table tr")
        
        Capybara.ignore_hidden_elements = false
        fill_in "hidden_card_list", :with => "1, Steppe Glider, , undefined"
        Capybara.ignore_hidden_elements = true

        click_button "Save"
        
        expect(page).to have_text("Steppe Glider")
        
    end
    
    it "should add chosen cards to the deck and then show cards that were errored for correction", :js => true do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        
        visit "/decks/#{master_deck.slug}/branch/main/editcards"
        page.evaluate_script 'jQuery.active == 0'
        
        fill_in "new-card-name", :with => "Steppe Glider"
        page.evaluate_script 'jQuery.active == 0'
        
        page.execute_script("$('#addCardBtn').trigger('click')")
        
        fill_in "new-card-name", :with => "Not A Real Card"
        page.evaluate_script 'jQuery.active == 0'
        
        page.execute_script("$('#addCardBtn').trigger('click')")

        expect(page).to have_css("#card-table tr")
        
        Capybara.ignore_hidden_elements = false
        fill_in "hidden_card_list", :with => "1, Steppe Glider, , undefined\n1, Not A Real Card, , undefined"
        
        Capybara.ignore_hidden_elements = true

        click_button "Save"
        
        expect(page).to have_text("Unable to find")
        
    end
    
    it "should remove chosen cards from the deck" 
    
    it "should save a history, by creating a new head deck, of changes to the deck"
    
    it "should show differences between two decks"
    
    
    

end
