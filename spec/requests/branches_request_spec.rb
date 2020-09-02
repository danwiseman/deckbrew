require 'rails_helper'
require_relative '../support/branch_helpers'
require_relative '../support/master_deck_helpers'
require_relative '../support/user_helpers'

include UserHelpers
include MasterDeckHelpers
include BranchHelpers

RSpec.describe "Branches", type: :request do
    
    it "creates a new branch of the deck and redirects to the new branch" do
       
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       master_deck = FactoryBot.create(:master_deck)

       visit "/decks/#{master_deck.slug}/branch/new"

       fill_in "name", :with => "new branch"
       click_button "Create"
       
       expect(page).to have_text("new branch") 
       
        
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
    
    
    it "shows the branch history of the master_deck" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)
        
        # generate a master deck with branches
        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/u/#{user.slug}/decks/#{master_deck.slug}/tree"
        
        expect(page).to have_text("branch2")
        
    end
    
    it "correctly shows deck differences and merges a branch into another branch" do
        user = FactoryBot.create(:user)
        sign_in_via_form(user)

        master_deck = create_master_deck_via_form(user)
        create_many_branches(master_deck)
        
        visit "/decks/#{master_deck.slug}/branch/compare/branch3"
        
        # select merge into master
        expect(page).to have_select 'source_branch[id]', selected: 'branch3'
        select 'main', from: 'destination_branch[destination_branch_id]'
        
        # merge
        click_button "Merge These Branches"
        
        # expect master to now have the deck of branch3
        expect(Deck.find(master_deck.branches.friendly.find("main").head_deck).cards).to eq(Deck.find(master_deck.branches.friendly.find("branch3").head_deck).cards)
        
    end

end
