require 'rails_helper'
require_relative '../support/user_helpers'

include UserHelpers


RSpec.describe "Users", type: :request do
    
    it "shows the user's profile screen after log in" do
    
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       expect(page).to have_current_path('/u/' + user.slug)
       
    end
    
    it "allows the user to update their profile" do
        
       user = FactoryBot.create(:user)
       sign_in_via_form(user)
       
       expect(page).to have_current_path('/u/' + user.slug)
       
       click_link "Edit Profile"
       
       expect(page).to have_current_path('/u/' + user.slug + '/edit')
       
       fill_in "user_profile_tagline", :with => "I like Liliana"
       fill_in "user_profile_twitter", :with => "mtgrocks"
       click_button "Update"
       
       expect(page).to have_content 'I like Liliana'
       expect(page).to have_selector '.fa-twitter'
       expect(page).to_not have_current_path '.fa-facebook'
        
    end

end
