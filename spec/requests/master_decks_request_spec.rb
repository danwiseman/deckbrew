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
    
    
    
    

end
