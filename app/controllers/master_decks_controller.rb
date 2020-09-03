class MasterDecksController < ApplicationController
    
       
    before_action :authenticate_user!, only: [:new, :create, :fork_deck]
    
    
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
        @master_deck = User.friendly.find(params[:user_id]).master_decks.friendly.find(params[:id]) 
        @show_full_breadcrumbs = false
        
        if params.has_key?(:user_id)
            @deck_user = User.friendly.find(params[:user_id])
        else
           @deck_user = current_user 
        end
        
        if (@master_deck.is_public == false && @deck_user != current_user)
            redirect_to action: 'no_permission', reason: "You are not authorized to view this deck."
            return
        end
        
        if params.has_key?(:branch_id)
           @selected_branch = @master_deck.branches.friendly.find(params[:branch_id])
           @show_full_breadcrumbs = true
        else
            @selected_branch = @master_deck.branches.friendly.find('main')
        end
       
       render layout: "dashboard"
    end
    
    def fork_deck
        @deck_to_fork = User.friendly.find(params[:user_id]).master_decks.friendly.find(params[:id]) 
        if params.has_key?(:branch_id)
           @selected_branch = @deck_to_fork.branches.friendly.find(params[:branch_id])
        else
            @selected_branch = @deck_to_fork.branches.friendly.find('main')
        end
        
        render layout: "dashboard"
    end
    
    def tree
        @master_deck = User.friendly.find(params[:user_id]).master_decks.friendly.find(params[:id])  
       
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
    
    def create_fork
        @deck_to_fork = MasterDeck.find(params[:forked_from_id]) 
        
        if @deck_to_fork.is_public == false || @deck_to_fork.user == current_user
            # private or same user
            redirect_to action: 'no_permission', reason: "You cannot fork this deck."
            return
        end
        
        
        if(MasterDeck.where(:name => params['name'], :user => current_user).present?) 
           # deck already exists fail.
           flash[:warning] = 'Deck with that name already exists.'
           render "new"
        else
            
           @master_deck = MasterDeck.new(:name => params['name'], :user => current_user, :deck_type => @deck_to_fork.deck_type,
                                        :description => @deck_to_fork.description, :is_public => params['is_public'], 
                                        :forked_from => @deck_to_fork.id, :forked_from_branch => @deck_to_fork.branches.friendly.find(params['forked_from_branch']['forked_from_branch_id']).id,
                                        :forked_from_deck => @deck_to_fork.branches.friendly.find(params['forked_from_branch']['forked_from_branch_id']).head_deck) 
           if @master_deck.save 
               # create an empty master branch
               createMasterBranch(@master_deck, params['is_public'])
               
               @merge_base = @master_deck.branches.friendly.find("main")
               @merge_source = @deck_to_fork.branches.friendly.find(params['forked_from_branch']['forked_from_branch_id'])
               
               @merge_base.decks.new(:version => @merge_base.decks.last.version+1,
                                    :previousversion => @merge_source.head_deck,
                                    :cards => @merge_source.decks.find(@merge_source.head_deck).cards)
               @merge_base.head_deck = @merge_base.decks.last
               
               
               flash[:success] = 'Deck was successfully created.'
               redirect_to MasterDecksHelper.PathToMasterDeck(@master_deck)
           else
              # error in saving
              flash[:warning] = 'Deck was not saved. Please try again.'
              render "new"
           end
        end
        
        
    end
    
    
    def no_permission
        @reason = params[:reason]
        render layout: "devise"
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
