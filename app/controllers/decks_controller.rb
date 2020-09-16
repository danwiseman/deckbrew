class DecksController < ApplicationController
    
    require 'csv'  
    
    before_action :authenticate_user!, only: [:edit, :addcards, :errorcards, :fixedcards]
    before_action :set_master_deck_and_current_branch, only: [:edit, :addcards, :errorcards, :fixedcards]
    

    def edit
        @head_deck = @branch.decks.find(@branch.head_deck)
        
        render layout: "dashboard"
    end
    
    def addcards
        #puts params
        
        unless !params[:hidden_card_list].present?
            # reference the head deck of the branch as the previous version
            new_version = Deck.find(@branch.head_deck).version + 1
            @branch.decks.create(:previousversion => @branch.head_deck, :version => new_version)
            # set the branch's head deck to the id of the new one.
            @branch.update(:head_deck => @branch.decks.last.id)
            
            # add the cards to a new deck
            error_cards = add_cards_to_deck(@branch.decks.last, params[:hidden_card_list])  
        
            #puts error_cards
            # redirect to the branch
            if error_cards.size == 0
                redirect_to BranchesHelper.PathToBranch(@branch)
            else
                # redirect to error cards
                errorcards(error_cards)
            end
        else
            flash[:info] = 'No cards were added.'
            redirect_to BranchesHelper.PathToBranch(@branch)
            
        end
        
        
    end
    
    def errorcards(error_cards)
        @error_cards = error_cards
        #puts @error_cards
        @possible_fixed_cards = Array.new
        for error_card in @error_cards
            # do a fuzzy search for each of the cards in there.
            
            # https://api.scryfall.com/cards/named?fuzzy=aust+com 
            page_url = 'https://api.scryfall.com/cards/named?fuzzy=' + error_card['name']
            uri = URI(page_url)
            response = Net::HTTP.get_response(uri)
            #puts response.body
            if response.kind_of? Net::HTTPSuccess
                data = JSON.parse(response.body)
                
                if data.key?('data')
                    data['data'].each do |card_json|
                        if(Card.where(:scryfall_id => card_json['id']).present?)
                            
                             newCard = Card.where(:scryfall_id => card_json['id']).first
                             newCard.update(:oracle_name => card_json['name'], :set => card_json['set'], :scryfall_data => card_json)
                        else    
                            
                            newCard = Card.create(:scryfall_id => card_json['id'], :oracle_name => card_json['name'], :set => card_json['set'], :scryfall_data => card_json)
                        end
                        @possible_fixed_cards << newCard
                    end
                else
                    if(Card.where(:scryfall_id => data['id']).present?)
                         newCard = Card.where(:scryfall_id => data['id']).first
                         newCard.update(:oracle_name => data['name'], :set => data['set'], :scryfall_data => data)
                    else    
                        newCard = Card.create(:scryfall_id => data['id'], :oracle_name => data['name'], :set => data['set'], :scryfall_data => data)
                    end
                    @possible_fixed_cards << newCard
                    
                end
                
                
            end
            # to provide possible corrections
            
            # render a form to allow the user to correct those cards
            
            # then re-add the cards without creating a new deck.
        end
        
        
        render layout: "dashboard"
            
        
    end

    def fixedcards
        
       cards_to_add = params[:fixed_card]
       
        
        cards_to_add.each do |params_card|
            parsed_card = params_card.to_json
            parsed_card = JSON.parse(parsed_card)
            card = Card.snatch(uuid: parsed_card['scryfall_id'])
            #puts parsed_card
            if (parsed_card['check'] == "on")
            unless(card.nil?) 
            
                new_card = [{
                  scryfall_id: card.scryfall_id,
                  quantity: parsed_card['quantity']
                }].to_json
                
                Deck.where(id: @branch.head_deck).update_all(["cards = cards || ?::jsonb", new_card])
            
            end 
            end
            
        end
        
        redirect_to BranchesHelper.PathToBranch(@branch)
        
    end

    private
    
    def set_master_deck_and_current_branch
        @master_deck = current_user.master_decks.friendly.find(params[:master_deck_id])
        @branch = @master_deck.branches.friendly.find(params[:branch_id])
        
    end
    
    def add_cards_to_deck(deck, cards_json)
        
        # set error cards array to empty
        error_cards = Array.new
        parsed_cards = JSON.parse(cards_json)
        parsed_cards.each do |parsed_card|
            
            
            card = Card.snatch(name: parsed_card['name'], set: parsed_card['set'])
            
            unless(card.nil?) 
            
                new_card = [{
                  scryfall_id: card.scryfall_id,
                  quantity: parsed_card['quantity']
                }].to_json
                
                Deck.where(id: deck.id).update_all(["cards = cards || ?::jsonb", new_card])
            
            else 
                # add the card errors to it
                unless parsed_card['name'].nil? || parsed_card['name'] == ""
                    error_cards << parsed_card
                    #puts "adding error card"
                end
            end
            
            
        end
        
        error_cards
    end
    
   
end
