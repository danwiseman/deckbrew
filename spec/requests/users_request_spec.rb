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

end
