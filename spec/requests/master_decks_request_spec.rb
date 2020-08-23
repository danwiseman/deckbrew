require 'rails_helper'
require 'request_helper'


RSpec.describe "MasterDecks", type: :request do
    
    
    
    it "creates a MasterDeck and redirects to the MasterDeck's page" do
        
        user = FactoryBot.create(:user)
        sign_in user
        
        get "/#{user.username}/decks/new"
        expect(response).to render_template(:new)
        
        master_deck = FactoryBot.create(:master_deck)
        post "/#{user.username}/decks/new", :params => { :name => master_deck.name }
    
        expect(response).to redirect_to("/#{user.username}/#{master_deck.name.parameterize('-')}")
        follow_redirect!
    
        expect(response).to render_template(:show)
        expect(response.body).to include("Deck was successfully created.")
        
    end
    
    it "creates a new branch of the deck and redirects to the new branch" do
       
       user = FactoryBot.create(:user)
       sign_in user
       master_deck = FactoryBot.create(:master_deck)
       deck = FactoryBot.create(:deck)
       
       get "/#{user.username}/#{master_deck.name.parameterize('-')}"
       expect(response).to render_template(:show)
       
       get "/#{user.username}/#{master_deck.name.parameterize('-')}/branch/new"
       expect(response).to render_template(:new_deck)
       
       post "/#{user.username}/#{master_deck.name.parameterize('-')}/branch/new", :params => { :branchname => "new branch" } 
       expect(response).to redirect_to("/#{user.username}/#{master_deck.name.parameterize('-')}/tree/new-branch")
       follow_redirect!
       
        
    end
    
    

end
