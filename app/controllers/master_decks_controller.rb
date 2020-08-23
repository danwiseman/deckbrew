class MasterDecksController < ApplicationController
    
   
    
    def index
        
    end
    
    
    def show
       @master_deck = MasterDeck.friendly.find(params[:id]) 
        
    end
    
    
    
    def new
        before_action :authenticate_user!
        
    end

    def create
        before_action :authenticate_user!
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
               redirect_to '/u/' + current_user.slug + '/decks/' +  @master_deck.slug
           else
              # error in saving
              render "new"
           end
        end
        
    end
    
end
