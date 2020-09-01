require 'rails_helper'
require 'request_helper'


RSpec.describe "MasterDecks", type: :request do
    
    
    
    it "creates a MasterDeck and redirects to the MasterDeck's page" do
        
        user = FactoryBot.create(:user)
        sign_in user
        
        
        master_deck = FactoryBot.build(:master_deck)
        visit "/decks/new"
        
        fill_in "name", :with => master_deck.name
        select "Commander", from: 'deck_type'
        check "is_public"
        fill_in "description", :with => master_deck.description
        click_button "Create"
    
        expect(page).to have_text(master_deck.name)
        
    end
    
    it "shows the branch history of the master_deck" do
        user = FactoryBot.create(:user)
        sign_in user
        
        # generate a master deck with branches
        master_deck = FactoryBot.create(:master_deck)
        visit "/decks/#{master_deck.slug}/branch/new/master"
        fill_in "name", :with => "branch1"
        click_button "Create"
        visit "/decks/#{master_deck.slug}/branch/new/master"
        fill_in "name", :with => "branch2"
        click_button "Create"
        visit "/decks/#{master_deck.slug}/branch/new/branch1"
        fill_in "name", :with => "branch3"
        click_button "Create"
        
        
        visit "/u/#{user.slug}/decks/#{master_deck.slug}/tree"
        
        expect(page).to have_text("branch2")
        
    end
    
    

end
