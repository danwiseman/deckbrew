module UserHelpers
    
    def sign_in_via_form(user)
        
        visit "/accounts/sign_in"
        fill_in "user_login", :with => user.username
        fill_in "user_password", :with => user.password
        click_button "Log in"
        
    end
    
end