module MasterDeckHelpers
    
    def create_master_deck_via_form(user)
        fbmaster_deck = FactoryBot.build(:master_deck)
        visit "/decks/new"
        
        fill_in "name", :with => fbmaster_deck.name
        select "Commander", from: 'deck_type'
        check "is_public"
        fill_in "description", :with => fbmaster_deck.description
        click_button "Next"
        
        Capybara.ignore_hidden_elements = false
        click_button "Create"
        Capybara.ignore_hidden_elements = true
        
        master_deck = MasterDeck.where(:name => fbmaster_deck.name, :user => user).last 
        
        master_deck
    end
    
end
