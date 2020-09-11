class DecksController < ApplicationController
    
    require 'csv'  
    
    before_action :authenticate_user!, only: [:edit, :addcards, :errorcards]
    before_action :set_master_deck_and_current_branch, only: [:edit, :addcards, :errorcards]
    

    def edit
        
        
        render layout: "dashboard"
    end
    
    def addcards
        puts params
        # reference the head deck of the branch as the previous version
        new_version = Deck.find(@branch.head_deck).version + 1
        @branch.decks.create(:previousversion => @branch.head_deck, :version => new_version)
        # set the branch's head deck to the id of the new one.
        @branch.update(:head_deck => @branch.decks.last.id)
        
        # add the cards to a new deck
        error_cards = add_cards_to_deck(@branch.decks.last, params[:hidden_card_list])  
        
        puts error_cards
        # redirect to the branch
        if error_cards.size == 0
            redirect_to BranchesHelper.PathToBranch(@branch)
        else
            # redirect to error cards
            errorcards(error_cards)
        end
    end
    
    def errorcards(error_cards)
        @error_cards = error_cards
        
        # do a fuzzy search for each of the cards in there.
        # to provide possible corrections
        
        # render a form to allow the user to correct those cards
        
        # then re-add the cards without creating a new deck.
        
        render layout: "dashboard"
    end

    private
    
    def set_master_deck_and_current_branch
        @master_deck = current_user.master_decks.friendly.find(params[:master_deck_id])
        @branch = @master_deck.branches.friendly.find(params[:branch_id])
        
    end
    
    def add_cards_to_deck(deck, csv)
        
        # set error cards array to empty
        error_cards = Array.new
        parsed_csv = CSV.parse(csv)
        parsed_csv.each do |row|
            card_qty = row[0]
            card_name = row[1]
            card_set_code = row[2]
            card_foil = row[3]
            
            card = get_card(card_name, card_set_code, card_foil)
            
            unless(card.nil?) 
            
                new_card = [{
                  scryfall_id: card.scryfall_id,
                  quantity: card_qty
                }].to_json
                
                Deck.where(id: deck.id).update_all(["cards = cards || ?::jsonb", new_card])
            
            else 
                # add the card errors to it
                error_cards << { qty: card_qty, name: card_name, set: card_set_code, foil: card_foil }
                puts "adding error card"
            end
            
            
        end
        
        error_cards
    end
    
    def get_card(card_name, set, foil)
       # check cards table for existance
       if (set == "" || set.nil? || set == "undefined")
            cards = Card.where(:oracle_name => card_name)
       else
           cards = Card.where(:oracle_name => card_name, :set => set)
       end
       # if it exists, return the uuid
       unless cards.empty?
           card = cards.first
           # if it exists, but has not been updated in 2 weeks...
           if(card.updated_at < (Time.now - 2.weeks)) 
                card = grab_from_scryfall(card.scryfall_id, card.oracle_name, card.set)
           end
           
           return card
       # OR if it does not exist
       else
            # Grab the details from Scryfall
             card = grab_from_scryfall(nil, card_name, set)
             return card
       end
       # return nil if there are any errors
       return nil
    end
    
    # returns a card object after grabbing it from scryfall
    def grab_from_scryfall(uuid, card_name, set)
        
        uri_search = "https://api.scryfall.com/cards/"
        q = ""
        
        if uuid != nil && uuid != ""
            # if uuid is not nil, update the card
            q = uuid
        elsif set != " " && set != "undefined" && set != nil
            # if set is valid, grab the specific card
            q = "search?order=set&q=%21%22#{card_name}%22&e%3A#{set}'"
        else
            # there's no set specified, so let scryfall just pick one
            q = "search?order=set&q=%21%22#{card_name}%22&unique=cards'"
        end
        # return the card that is created/updated
        
        
        page_url = uri_search + q
        puts page_url
        uri = URI(page_url)
        response = Net::HTTP.get_response(uri)
        if response.kind_of? Net::HTTPSuccess
            data = JSON.parse(response.body)
           
            new_cards = Array.new
            data['data'].each do |card_json|
                if(Card.where(:scryfall_id => card_json['id']).present?)
                     newCard = Card.where(:scryfall_id => card_json['id']).first
                     newCard.update(:oracle_name => card_json['name'], :set => card_json['set'], :scryfall_data => card_json)
                else    
                    newCard = Card.create(:scryfall_id => card_json['id'], :oracle_name => card_json['name'], :set => card_json['set'], :scryfall_data => card_json)
                end
                new_cards << newCard
            end
            
            return new_cards.last
        end
        return nil
    end
end
