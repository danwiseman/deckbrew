class BranchesController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]
    before_action :set_master_deck, only: [:new, :create, :show]
    
    def new
        @current_branches = @master_deck.branches.all
        
    end
    
    
    def create
        
        if(@master_deck.branches.where(:name => params['name']).present?) 
           # branch already exists fail.
           flash[:warning] = 'A branch for this deck with that name already exists.'
           render "new"
        else
           @branch = Branch.new(:name => params['name'], :master_deck => @master_deck, 
                                :branched_from => params['branched_from']['branched_from_id'], 
                                :branched_from_deck => Branch.find(params['branched_from']['branched_from_id']).head_deck) 
           if @branch.save 
               # create the branch's deck
               @branch.decks.create(:version => 0) 
               
               @branch.save!
               
               flash[:success] = 'Branch was successfully created.'
               redirect_to '/u/' + current_user.slug + '/decks/' +  @master_deck.slug + '/branch/' + @branch.slug
           else
              # error in saving
              render "new"
           end
        end
    end
    
    def show 
        @branch = @master_deck.branches.friendly.find(params['id'])
        
    end
    
    private
    
    def set_master_deck
        @master_deck = MasterDeck.friendly.find(params[:master_deck_id])
    end
    
end
