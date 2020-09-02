module BranchHelpers
    
    def create_many_branches(master_deck)
        visit "/decks/#{master_deck.slug}/branch/new/main"
        fill_in "name", :with => "branch1"
        click_button "Create"
        visit "/decks/#{master_deck.slug}/branch/new/main"
        fill_in "name", :with => "branch2"
        click_button "Create"
        visit "/decks/#{master_deck.slug}/branch/new/branch1"
        fill_in "name", :with => "branch3"
        click_button "Create" 
        
    end
    
end