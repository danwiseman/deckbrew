require 'rails_helper'

RSpec.describe "Branches", type: :request do
    
    it "creates a new branch of the deck and redirects to the new branch" do
       
       user = FactoryBot.create(:user)
       #sign_in user
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       master_deck = FactoryBot.create(:master_deck)

       visit "/decks/#{master_deck.slug}/branch/new"

       
       fill_in "name", :with => "new branch"
       click_button "Create"
       
       expect(page).to have_text("new branch") 
       
        
    end
    
    
    it "correctly branches from the selected branch and correct deck" do
        
       user = FactoryBot.create(:user)
       #sign_in user
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       master_deck = FactoryBot.create(:master_deck)

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
       #sign_in user
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       master_deck = FactoryBot.create(:master_deck)

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
    
    it "correctly shows deck differences and merges a branch into another branch" do
        user = FactoryBot.create(:user)
        sign_in user
        
        # generate a master deck with lots of branches
        fbmaster_deck = FactoryBot.build(:master_deck)
        visit "/decks/new"
        
        fill_in "name", :with => fbmaster_deck.name
        select "Commander", from: 'deck_type'
        check "is_public"
        fill_in "description", :with => fbmaster_deck.description
        click_button "Create"
        
        master_deck = MasterDeck.where(:name => fbmaster_deck.name, :user => user).last
        
        visit "/decks/#{master_deck.slug}/branch/new/main"
        fill_in "name", :with => "branch1"
        click_button "Create"
        visit "/decks/#{master_deck.slug}/branch/new/main"
        fill_in "name", :with => "branch2"
        click_button "Create"
        visit "/decks/#{master_deck.slug}/branch/new/branch1"
        fill_in "name", :with => "branch3"
        click_button "Create"
        
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
