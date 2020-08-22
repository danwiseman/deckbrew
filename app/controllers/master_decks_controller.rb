class MasterDecksController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        
    end

    def new
        
    end

    def create
        if(MasterDeck.where(:name => params['master_deck']['name'], :user => current_user).present?) 
           # deck already exists fail.
           flash[:warning] = 'Deck with that name already exists.'
           render "new"
        else
           @master_deck = MasterDeck.new(:name => params['master_deck']['name'], :user => current_user) 
           if @master_deck.save 
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
