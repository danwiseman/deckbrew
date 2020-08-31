class MasterDecksController < ApplicationController
    
       
    
    before_action :authenticate_user!, only: [:new, :create]
    
    
    def index

        if params.has_key?(:user_id)
            @deck_user = User.friendly.find(params[:user_id])
        else
           @deck_user = current_user 
        end
        @master_decks = MasterDeck.where(:user => @deck_user)
        
        render layout: "dashboard"
    end
    
    
    def show
        
       @master_deck = MasterDeck.friendly.find(params[:id]) 
       
       render layout: "dashboard"
        
    end

    def new
        
        render layout: "dashboard"
    end

    def create
        
        if(MasterDeck.where(:name => params['name'], :user => current_user).present?) 
           # deck already exists fail.
           flash[:warning] = 'Deck with that name already exists.'
           render "new"
        else
           @master_deck = MasterDeck.new(:name => params['name'], :user => current_user, :deck_type => params['deck_type'],
                                        :description => params['description'], :is_public => params['is_public']) 
           if @master_deck.save 
               # create an empty master branch
               
               @master_deck.branches.create(:name => 'master', :is_public => params['is_public']) 
               mbr = @master_deck.branches.friendly.find("master")
               mbr.decks.create(:version => 0, :previousversion => 0)
               #mbr.head_deck = nd.id
               mbr.save!
               
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
