class MasterDecksController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        
    end

    def new
        
    end

    def create
        puts params
        if(MasterDeck.where(:name => params['name'], :user => current_user).present?) 
           # deck already exists fail.
           flash[:warning] = 'Deck with that name already exists.'
           render "new"
        else
           @master_deck = MasterDeck.new(:name => params['name'], :user => current_user) 
           if @master_deck.save 
               # create an empty master branch with a previous deck of 0 to denote it is the root deck
               @master_deck.decks.create(:branchname => 'master', :previousdeck => 0) 
               # set the head as the only deck in the master deck
               @master_deck.head = @master_deck.decks.last.id
               @master_deck.save!
               
               flash[:success] = 'Deck was successfully created.'
               redirect_to @master_deck
           else
              # error in saving
              render "new"
           end
        end
        
    end
    
    def show
       @master_deck = MasterDeck.find(params[:id]) 
        
    end
end
