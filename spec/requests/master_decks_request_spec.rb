require 'rails_helper'
require 'request_helper'

require_relative '../support/branch_helpers'
require_relative '../support/master_deck_helpers'
require_relative '../support/user_helpers'

include UserHelpers
include MasterDeckHelpers
include BranchHelpers


RSpec.describe "MasterDecks", type: :request do
    
    
    
    it "creates a MasterDeck and redirects to the MasterDeck's page" do
        
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        master_deck = create_master_deck_via_form(user)
    
        expect(page).to have_text(master_deck.name)
        
    end
    
    
    

end
