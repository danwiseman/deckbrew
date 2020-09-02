module NavigationHelper
    
    def breadcrumbs(user, master_deck=nil, branch=nil)
        
        
        user_link_class = "breadcrumb-item"
        master_deck_link_class = "breadcrumb-item"
        branch_link_class = "breadcrumb-item active" # if this is showing, it's active
        
        if master_deck.nil?
            user_link_class += " active"
        end
        if  branch.nil?
            master_deck_link_class += " active"
        end
        
        tag.nav role: "navigation", aria: { label: "breadcrumb" } do
          tag.ol class: "breadcrumb" do
            master_deck_link = ""
            branch_link = ""
            user_link = tag.li class: user_link_class do
                link_to  user.username, UsersHelper.PathToUser( user )    
            end
            unless master_deck.nil?
                master_deck_link = tag.li class: master_deck_link_class do
                    unless branch.nil?
                        link_to  master_deck.name, MasterDecksHelper.PathToMasterDeck(master_deck) 
                    else
                        master_deck.name
                    end
                end
            end
            unless branch.nil?
                branch_link = tag.li class: branch_link_class do
                    branch.name   
                end
            end
            user_link + master_deck_link + branch_link
          end
        end.html_safe
   
    end
    
    def navbar_signed_in_user_dropdown
        tag.ul class: "navbar-nav" do
                user_nav = tag.li class: "nav-item dropdown" do
                    nav_link = tag.a class: "nav-link", href: "javascript:;", id: "navbarDropdownProfile", data: { toggle: "dropdown" }, aria: { haspopup: "true", expanded: "false"} do
                        nav_i = tag.i class: "material-icons" do
                            "person"
                        end
                        nav_p = tag.p class: "d-lg-none d-md-block" do 
                            "Account"
                        end
                        nav_i + nav_p
                    end
                    nav_div = tag.div class: "dropdown-menu dropdown-menu-right", aria: { labelledby: "navbarDropdownProfile" } do
                        nav_a = tag.a class: "dropdown-item", href: "#{UsersHelper.PathToUser(current_user)}" do
                            "Profile"
                        end
                        nav_div_inner = tag.div class: "dropdown-divider"
                        nav_aa = tag.a class: "dropdown-item", href: "/accounts/sign_out" do
                            "Log out"
                        end
                        nav_a + nav_div_inner + nav_aa
                    end
                    nav_link + nav_div
                end
            user_nav
        end.html_safe
    end
    
    def navbar_no_user_dropdown
        tag.ul class: "navbar-nav" do
            user_nav = tag.li class: "nav-item" do
                tag.a href: "/accounts/sign_in", class:"nav-link" do
                    "Sign In"
                end
            end
            user_nav += tag.li class: "nav-item active" do
                tag.a href: "/accounts/sign_up", class:"nav-link" do
                    "Sign Up"
                end
            end
            user_nav
        end.html_safe
    end
    
    

end
