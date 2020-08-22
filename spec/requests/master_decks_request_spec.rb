require 'rails_helper'
require 'request_helper'


RSpec.describe "MasterDecks", type: :request do
    
    
    
    it "creates a MasterDeck and redirects to the MasterDeck's page" do
        
        user = FactoryBot.create(:user)
        sign_in user
        
        get "/decks/new"
        expect(response).to render_template(:new)
        
        master_deck = FactoryBot.create(:master_deck)
        post "/decks", :params => { :master_deck => master_deck }
    
        expect(response).to redirect_to(assigns(:master_deck))
        follow_redirect!
    
        expect(response).to render_template(:show)
        expect(response.body).to include("Deck was successfully created.")
        
    end
    
    
    

end
