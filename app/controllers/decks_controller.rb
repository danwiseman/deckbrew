class DecksController < ApplicationController
    
    require 'csv'  
    
    before_action :authenticate_user!, only: [:edit, :addcards, :errorcards]
    before_action :set_master_deck_and_current_branch, only: [:edit, :addcards, :errorcards]
    

    def edit
        @head_deck = @branch.decks.find(@branch.head_deck)
        
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
            
            card = Card.snatch(name: card_name, set: card_set_code)
            
            unless(card.nil?) 
            
                new_card = [{
                  scryfall_id: card.scryfall_id,
                  quantity: card_qty
                }].to_json
                
                Deck.where(id: deck.id).update_all(["cards = cards || ?::jsonb", new_card])
            
            else 
                # add the card errors to it
                unless card_name.nil? || card_name == ""
                    error_cards << { qty: card_qty, name: card_name, set: card_set_code, foil: card_foil }
                    puts "adding error card"
                end
            end
            
            
        end
        
        error_cards
    end
    
   
end
