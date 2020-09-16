module DeckHelpers
   
   
    def add_cards(master_deck, branch)
    
        visit "/decks/#{master_deck.slug}/branch/#{branch.slug}/editcards"

        fill_in "new-card-name", :with => "Steppe Glider"
        click_button "addCardBtn"

        fill_in "new-card-name", :with => "Tree of Perdition"
        click_button "addCardBtn"
        
        fill_in "new-card-name", :with => "Swamp"
        click_button "addCardBtn"       
       
       
        click_button "Save"
        

        
    end
    
    
end