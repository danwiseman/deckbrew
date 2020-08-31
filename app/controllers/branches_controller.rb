class BranchesController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]
    before_action :set_master_deck, only: [:new, :create, :show]
    
    def new
        @current_branches = @master_deck.branches.all
        
        render layout: "dashboard"
    end
    
    
    def create
        
        if(@master_deck.branches.where(:name => params['name']).present?) 
           # branch already exists fail.
           flash[:warning] = 'A branch for this deck with that name already exists.'
           render "new"
        else
           @branch = Branch.new(:name => params['name'], :master_deck => @master_deck, 
                                :branched_from => params['branched_from']['branched_from_id'], 
                                :branched_from_deck => Branch.find(params['branched_from']['branched_from_id']).decks.last.id) 
           if @branch.save 
               @branch.decks.create(:version => 0, :previousversion => Branch.find(params['branched_from']['branched_from_id']).decks.last.id) 
               @branch.save!
               
               flash[:success] = 'Branch was successfully created.'
               redirect_to BranchesHelper.PathToBranch(@branch)
           else
              # error in saving
              flash[:warning] = "An error occurred. Could not save the branch"
              render "new"
           end
        end
    end
    
    def show 
        @branch = @master_deck.branches.friendly.find(params['id'])
        
        render layout: "dashboard"
    end
    
    private
    
    def set_master_deck
        @master_deck = MasterDeck.friendly.find(params[:master_deck_id])
    end
    
    
end
