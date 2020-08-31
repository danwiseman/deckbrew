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
    
    it "creates a new branch of the deck and redirects to the new branch" do
       
       user = FactoryBot.create(:user)
       #sign_in user
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       master_deck = FactoryBot.create(:master_deck)

       visit "/decks/#{master_deck.slug}/branch/new"

       
       fill_in "name", :with => "new branch"
       click_button "Create"
       
       expect(page).to have_text("new branch") 
       
        
    end
    
    

end
