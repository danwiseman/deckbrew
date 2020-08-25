require 'rails_helper'

RSpec.describe "Users", type: :request do
    
    it "shows the user's profile screen after log in" do
    
       user = FactoryBot.create(:user)
       
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       expect(page).to have_current_path('/u/' + user.slug)
       
    end
    
    it "allows the user to update their profile" do
        
        user = FactoryBot.create(:user)
       
       visit "/accounts/sign_in"
       fill_in "user_login", :with => user.username
       fill_in "user_password", :with => user.password
       click_button "Log in"
       
       expect(page).to have_current_path('/u/' + user.slug)
       
       click_link "Edit Profile"
       
       expect(page).to have_current_path('/u/' + user.slug + '/edit')
       
       fill_in "user_tagline", :with => "I like Liliana"
       click_button "Update"
       
       expect(page).to have_content 'I like Liliana'
        
    end

end
