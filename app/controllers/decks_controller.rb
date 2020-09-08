class DecksController < ApplicationController
    
    before_action :authenticate_user!, only: [:edit, :addcards]
    before_action :set_master_deck_and_current_branch, only: [:edit, :addcards]
    

    def edit
        
        
        render layout: "dashboard"
    end
    
    def addcards
        # add the cards to a new deck
        # reference the head deck of the branch as the previous version
        # set the version as the head deck version + 1
        # set the branch's head deck to the id of the new one.
        
    end

    private
    
    def set_master_deck_and_current_branch
        @master_deck = current_user.master_decks.friendly.find(params[:master_deck_id])
        @branch = @master_deck.branches.friendly.find(params[:branch_id])
        
    end
    
    def add_cards_to_deck(deck, csv)
        
        # set error cards array to empty
        
        CSV.foreach(csv, headers: false) do |row|
            card_qty = row[0]
            card_name = row[1]
            card_set_code = row[2]
            card_foil = row[3]
            
            if(sf_uuid = get_card(card_name, card_set_code, card_foil)) 
            
                new_card = [{
                  scryfall_id: sf_uuid,
                  quantity: card_qty
                }].to_json
                
                deck.update_all(["cards = cards || ?::jsonb", new_card])
            
            else 
                # add the card errors to it
            end
            
            
        end
        
    end
    
    def get_card(card_name, set, foil)
       # check cards table for existance
       if (set == "")
            cards = Card.where(:name => card_name)
       else
           cards = Card.where(:name => card_name, :set => set)
       end
       # if it exists, return the uuid
       if cards.size > 0
           card = cards.first
           # if it exists, but has not been updated in 2 weeks...
           if(card.updated_at < (Time.now - 2.weeks)) 
                card = grab_from_scryfall(card.scryfall_id, card.name, card.set)
           end
           
           return card.scryfall_id
       # OR if it does not exist
       else
       # Grab the details from Scryfall
            return grab_from_scryfall(nil, card_name, set).scryfall_id
       end
       # return false if there are any errors
       return false
    end
    
    # returns a card object after grabbing it from scryfall
    def grab_from_scryfall(uuid, card_name, set)
        # if uuid is not nil, update the card
        # if set is blank, just grab the default card from SF
        # if set is valid, grab the specific card
        # return the card that is created/updated
        # otherwise, return false
        # uri = URI(page_url)
        # response = Net::HTTP.get(uri)
        # data = JSON.parse(response)
        # data['data'].each do |card|
        
    end
end
