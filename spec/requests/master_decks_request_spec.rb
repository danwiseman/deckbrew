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
    
       
    it "shows the branch history of the master_deck" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/u/#{user.slug}/decks/#{master_deck.slug}/tree"
        
        expect(page).to have_text("branch2")
        
    end
    
    it "shows the selected branch of the master deck" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/u/#{user.slug}/decks/#{master_deck.slug}/branch/branch2"
        expect(page).to have_selector 'a#selected_branch', text: 'branch2'
        
    end
    
    it "forks another user's deck into a new master_deck" do
       user = FactoryBot.create(:user)
       second_user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       # generate a master deck with branches
        master_deck_to_fork = create_master_deck_via_form(user)
        create_many_branches(master_deck_to_fork)
        
        sign_out_via_link
        
        sign_in_via_form(second_user)
        visit "/u/#{user.slug}/decks/#{master_deck_to_fork.slug}/branch/branch2"
        
        click_link "Fork This Deck"
        
        expect(page).to have_text("forked from #{user.username}/#{master_deck_to_fork.name}")
        
        
        
    end
    
    

end
