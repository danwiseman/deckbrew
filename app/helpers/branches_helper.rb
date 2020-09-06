module BranchesHelper
    
    def self.PathToBranch(branch)
        MasterDecksHelper.PathToMasterDeck(branch.master_deck) + '/branch/' + branch.slug
    end
    
    def branch_with_privacy_badge(branch, is_linked=false)
        output = ""
        if is_linked
            output = tag.a href: BranchesHelper.PathToBranch(branch) do
                branch.name
            end
        else
            output = branch.name
        end
        output += " "
        if branch.is_public?
            output += tag.span "Public", class: "badge badge-success"
        else
            output += tag.span "Private", class: "badge badge-default"
        end
        output.html_safe
    end
    
    def can_show_branch(branch)
       can_show = false
       unless(branch.deleted == true)
            if (branch.is_public == true)
                can_show = true
            else
                if(branch.master_deck.user == current_user)
                    can_show = true
                end
            end
        end
        can_show
    end
    
    def branch_dropdown_menu (master_deck, current_branch)
        dropdown_menu = ""
        dropdown_menu = tag.div class: "dropdown-menu" do
          branch_items = ""
          create_branch_portion = ""
          for branch_li in master_deck.branches
            if can_show_branch(branch_li)
                branch_items += tag.a branch_with_privacy_badge(branch_li, false), class: "dropdown-item", href: BranchesHelper.PathToBranch(branch_li)
            end
          end
          if master_deck.user == current_user
            create_branch_portion += tag.div class: "dropdown-divider"
            create_branch_portion += tag.a "Create a new branch", class: "dropdown-item", href: "/decks/#{master_deck.slug}/branch/new/#{ current_branch.slug }"
            create_branch_portion
          end
          branch_items.html_safe + create_branch_portion.html_safe
        end
        dropdown_menu.html_safe
    end
end
