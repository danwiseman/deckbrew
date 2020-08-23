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
       sign_in user
       
       master_deck = FactoryBot.create(:master_deck)
       post "/decks", :params => { :name => master_deck.name }
    
       expect(response).to redirect_to("/u/#{user.slug}/decks/#{master_deck.slug}")
       follow_redirect!
        
       expect(response).to render_template(:show)
       
       get "/decks/#{master_deck.slug}/branch/new"
       expect(response).to render_template(:new_branch)
       
       post "/decks/#{master_deck.slug}/branch", :params => { :name => "new branch" } 
       expect(response).to redirect_to("/u/#{user.slug}/#{master_deck.slug}/tree/new-branch")
       follow_redirect!
       
        
    end
    
    

end
