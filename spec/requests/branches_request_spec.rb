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

end
