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
        
        click_button "addCardBtn"
        
        sleep 2

        expect(page).to have_css("#card-table tr")


        click_button "Save"
        
        expect(page).to have_css(".mtgcard img", :count => 1)
        
    end
    
    it "should add chosen cards to the deck and then show cards that were errored for correction", :js => true do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        
        visit "/decks/#{master_deck.slug}/branch/main/editcards"
        page.evaluate_script 'jQuery.active == 0'
        
        fill_in "new-card-name", :with => "Steppe Glider"
        click_button "addCardBtn"
        
        
        fill_in "new-card-name", :with => "Not A Real Card"
        click_button "addCardBtn"
        
        fill_in "new-card-name", :with => "Tree of Per"
        click_button "addCardBtn"
       

        click_button "Save"
        
        expect(page).to have_text("Unable to find")
        
        
        find('label', :text => 'Tree of Perdition').click
        
        
        click_button "Submit Fixed Cards"
        
        # todo: fix this to actually search for the card
        expect(page).to  have_css(".mtgcard img", :count => 2)
        
        
    end
    
    
    
    it "should remove chosen cards from the deck", :js => true do
       user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        
        visit "/decks/#{master_deck.slug}/branch/main/editcards"
        page.evaluate_script 'jQuery.active == 0'
        
        visit "/decks/#{master_deck.slug}/branch/main/editcards"
        page.evaluate_script 'jQuery.active == 0'
        
        fill_in "new-card-name", :with => "Steppe Glider"
        click_button "addCardBtn"
        
        
        fill_in "new-card-name", :with => "Tree of Perdition"
        click_button "addCardBtn"
        

        click_button "Save"
        
        expect(page).to have_css(".mtgcard img", :count => 2) 
        
        visit "/decks/#{master_deck.slug}/branch/main/editcards"
        
        expect(all('tr').count).to eq(3)
        
        click_button "remove_card1"
        
        expect(all('tr').count).to eq(2)
        
        click_button "Save"
        
        expect(page).to have_css(".mtgcard img", :count => 1)
        
        
        
    end
    
    it "should save a history, by creating a new head deck, of changes to the deck"
    
    it "should show differences between two decks"
    
    
    

end
