require 'rails_helper'
require_relative '../support/branch_helpers'
require_relative '../support/master_deck_helpers'
require_relative '../support/user_helpers'
require_relative '../support/deck_helpers'

include UserHelpers
include MasterDeckHelpers
include BranchHelpers
include DeckHelpers


RSpec.describe "Branches", type: :request do
    
    it "creates a new branch of the deck and redirects to the new branch" do
       
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       master_deck = create_master_deck_via_form(user)

       visit "/decks/#{master_deck.slug}/branch/new"

       fill_in "name", :with => "new branch"
       click_button "Create"
       
       expect(page).to have_text("new branch") 
       
        
    end
    
    it "does not create a new branch of the deck if one exists by that name" do
       
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       master_deck = create_master_deck_via_form(user)
       create_many_branches(master_deck)

       visit "/decks/#{master_deck.slug}/branch/new"

       fill_in "name", :with => "branch3"
       click_button "Create"

       expect(page).to have_content 'already exists'
        
    end
    
    
    it "correctly branches from the selected branch and correct deck" do
        
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       master_deck = create_master_deck_via_form(user)
       visit "/decks/#{master_deck.slug}/branch/new"

       fill_in "name", :with => "new branch"
       click_button "Create"
       
       expect(page).to have_text("new branch") 
       
       visit "/decks/#{master_deck.slug}/branch/new"

       fill_in "name", :with => "should branch from new branch"
       select "new branch", from: "branched_from[branched_from_id]"
       click_button "Create"
       
       expect(page).to have_text("branched from new branch")
    
    end
    
    it "uses the selected branch when the user wants to branch from it" do
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       master_deck = create_master_deck_via_form(user)

       visit "/decks/#{master_deck.slug}/branch/new"

       fill_in "name", :with => "new branch"
       click_button "Create"
       
       expect(page).to have_text("new branch") 
       
       visit "/decks/#{master_deck.slug}/branch/new/new-branch"
       expect(page).to have_select 'branched_from[branched_from_id]', selected: 'new branch'
       
       fill_in "name", :with => "should branch from new branch"
       #select "new branch", from: "branched_from[branched_from_id]"
       click_button "Create"
       
       expect(page).to have_text("branched from new branch")
      
    end
    
 
    
    it "correctly shows deck differences and merges a branch into another branch", :js => true do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)

        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        add_cards(master_deck, master_deck.branches.friendly.find('branch3'))
        
        visit "/decks/#{master_deck.slug}/branch/compare/branch3"
        
        
        find("#source_col").click
        
        find("#source_col").click_on "branch3"
        
        # merge
        click_button "Merge These Branches"
        
        # expect master to now have the deck of branch3
        expect(Deck.find(master_deck.branches.friendly.find("main").head_deck).cards).to eq(Deck.find(master_deck.branches.friendly.find("branch3").head_deck).cards)
        
    end
    
    it "allows the user to make changes to the branch name" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)

        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/decks/#{master_deck.slug}/branch/edit/branch3"
        
        fill_in "branch[name]",:with => "a new branch name"
        
        click_button "Edit"
       
        expect(page).to have_text("a new branch name") 
        
    end
    
    it "allows the user to delete a branch from the edit page" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)

        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/decks/#{master_deck.slug}/branch/delete/branch3"
        
        
        expect(page).to_not have_text("branch3")
        
    end

end
