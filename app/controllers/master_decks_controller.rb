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
               # create an empty master branch
               @master_deck.branches.create(:name => 'master') 
               
               @master_deck.save!
               
               flash[:success] = 'Deck was successfully created.'
               redirect_to '/u/' + current_user.username + '/decks/' +  @master_deck.slug
           else
              # error in saving
              render "new"
           end
        end
        
    end
    
    def show
       @master_deck = MasterDeck.friendly.find(params[:id]) 
        
    end
end
