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
    
    

end
