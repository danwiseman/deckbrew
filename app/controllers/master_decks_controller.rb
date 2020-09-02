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
    
    def tree
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
               createMasterBranch(@master_deck, params['is_public'])
               
               flash[:success] = 'Deck was successfully created.'
               redirect_to MasterDecksHelper.PathToMasterDeck(@master_deck)
           else
              # error in saving
              flash[:warning] = 'Deck was not saved. Please try again.'
              render "new"
           end
        end
        
        
    end
    
    
    private
    
    def createMasterBranch(master_deck, is_public)
        
        # create a default master branch that is (currently) not branched from anything.
        # TODO: add a forked from field
        master_deck.branches.create(:name => 'main', :is_public => is_public, 
                                    :source_branch => 0, 
                                    :source_deck => 0)
        
        # create a default deck for the new master branch
        master_branch = master_deck.branches.friendly.find("main")
        #master_branch.update()

            
        master_branch.decks.create(:version => 0, :previousversion => 0)
        master_branch.head_deck = master_branch.decks.last.id
        
        master_branch.save!
        master_deck.save!
    end
    
end
