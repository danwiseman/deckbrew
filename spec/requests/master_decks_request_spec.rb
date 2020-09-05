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
    
    it "does not allow non-users and other users to view private decks" do
        user = FactoryBot.create(:user)
       second_user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       # generate a master deck with branches
        master_deck_to_not_view = create_private_master_deck_via_form(user)
        
        
        sign_out_via_link
        
        sign_in_via_form(second_user)
        visit "/u/#{user.slug}/decks/#{master_deck_to_not_view.slug}"
        
        expect(page).to have_text("You are not authorized to view this deck")
        
    end
    
    it "does not show the fork option for the user's own decks" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
       
        # generate a master deck with branches
        master_deck_to_not_fork = create_master_deck_via_form(user)
        create_many_branches(master_deck_to_not_fork)
        
        visit "/u/#{user.slug}/decks/#{master_deck_to_not_fork.slug}/"
        
        expect(page).to_not have_link("Fork This Deck")
        
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
        
        expect(page).to have_text("Select the branch to fork from")
        select "branch3", from: 'forked_from_branch[forked_from_branch_id]'
        click_button "Fork"
        
        forked_master_deck = user.master_decks.friendly.find(master_deck_to_fork.slug) 
        
        expect(page).to have_text("Forked from: #{user.username}/#{master_deck_to_fork.name}")
        expect(Deck.find(forked_master_deck.branches.friendly.find("main").head_deck).cards).to eq(Deck.find(master_deck_to_fork.branches.friendly.find("branch3").head_deck).cards)
        
        
    end
    
    it "does not allow the user to fork their own decks" do 
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
       
        # generate a master deck with branches
        master_deck_to_not_fork = create_master_deck_via_form(user)
        create_many_branches(master_deck_to_not_fork)
        
        visit "/u/#{user.slug}/decks/#{master_deck_to_not_fork.slug}/fork"
        click_button "Fork"
        
        expect(page).to have_text("You cannot fork this deck")
        
    end
    
    
    it "does not allow the user to fork private decks" do
        user = FactoryBot.create(:user)
       second_user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       # generate a master deck with branches
        master_deck_to_not_fork = create_private_master_deck_via_form(user)
        create_many_branches(master_deck_to_not_fork)
        
        sign_out_via_link
        
        sign_in_via_form(second_user)
        visit "/u/#{user.slug}/decks/#{master_deck_to_not_fork.slug}/fork"
        click_button "Fork"
        
        expect(page).to have_text("You cannot fork this deck")
        
    end
    
    it "does not allow the user to see private branches in a public deck" do
        user = FactoryBot.create(:user)
       second_user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/decks/#{master_deck.slug}/branch/edit/branch3"
        
        uncheck "branch[is_public]"
        
        click_button "Edit"
        
        sign_out_via_link
        
        sign_in_via_form(second_user)
        visit "/u/#{user.slug}/decks/#{master_deck.slug}"
        
        
        expect(page).to_not have_text("branch3")
        
    end

end
