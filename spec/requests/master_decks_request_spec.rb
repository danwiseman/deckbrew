require 'rails_helper'
require 'request_helper'


RSpec.describe "MasterDecks", type: :request do
    
    
    
    it "creates a MasterDeck and redirects to the MasterDeck's page" do
        
        user = FactoryBot.create(:user)
        sign_in user
        
        get "/decks/new"
        expect(response).to render_template(:new)
        
        master_deck = FactoryBot.create(:master_deck)
        post "/decks", :params => { :name => master_deck.name }
    
        expect(response).to redirect_to("/u/#{user.slug}/decks/#{master_deck.slug}")
        follow_redirect!
    
        expect(response).to render_template(:show)
        expect(response.body).to include("Deck was successfully created.")
        
    end
    
    it "creates a new branch of the deck and redirects to the new branch" do
       
       user = FactoryBot.create(:user)
       #sign_in user
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       master_deck = FactoryBot.create(:master_deck)
       visit "/decks/new"
       fill_in "name", :with => master_deck.name
       click_button "Create"
    
       
       visit "/decks/#{master_deck.slug}/branch/new"
       #expect(response).to render_template("branches/new")
       
       fill_in "name", :with => "new branch"
       click_button "Create"
       
       #post "/decks/#{master_deck.slug}/branch", :params => { :name => "new branch" } 
       expect(response).to redirect_to("/u/#{user.slug}/decks/#{master_deck.slug}/branch/new-branch")
       follow_redirect!
       
        
    end
    
    

end
