class BranchesController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]
    before_action :set_master_deck, only: [:new, :create, :show, :compare, :merge]
    
    def new
        @current_branches = @master_deck.branches.all
        if params.has_key?(:branched_from_id)
            @branched_from_id = @master_deck.branches.friendly.find(params['branched_from_id']).id
        else 
            @branched_from_id = nil
        end
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
               @branch.head_deck = @branch.decks.last.id
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
    
    def compare
        if params.has_key?(:source_branch)
            @source_branch = @master_deck.branches.friendly.find(params['source_branch'])
        else
            @source_branch = @master_deck.branches.friendly.find('main')
        end
        @current_branches = @master_deck.branches.all
        render layout: "dashboard"
    end
    
    def merge
       source_b_id = params['source_branch']['id']
       dest_b_id = params['destination_branch']['destination_branch_id']
       
        unless source_b_id == dest_b_id
           @merge_base = @master_deck.branches.friendly.find(dest_b_id)
           @merge_source = @master_deck.branches.friendly.find(source_b_id)
           
           @merge_base.decks.new(:version => @merge_base.decks.last.version+1,
                                :previousversion => @merge_source.head_deck,
                                :cards => @merge_source.decks.find(@merge_source.head_deck).cards)
           @merge_base.head_deck = @merge_base.decks.last
           
           flash[:success] = 'Branch was merged.'
           redirect_to BranchesHelper.PathToBranch(@merge_base)
           
        else
            flash[:warning] = 'Both branches cannot be the same to merge.'
            render "compare"
        end
       
       
    end
    
    private
    
    def set_master_deck
        @master_deck = MasterDeck.friendly.find(params[:master_deck_id])
    end
    
    
end
