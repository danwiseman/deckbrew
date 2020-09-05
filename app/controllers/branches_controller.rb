class BranchesController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create, :merge, :edit, :update, :delete]
    before_action :set_master_deck, only: [:new, :create, :edit, :show, :compare, :merge, :update, :delete]
    
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
                                 :source_branch => params['branched_from']['branched_from_id'], 
                                 :source_deck => Branch.find(params['branched_from']['branched_from_id']).decks.last.id)
        
                                
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
    
    def edit
        @branch = @master_deck.branches.friendly.find(params['branch_id'])
        
        
        render layout: "dashboard" 
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
           
           new_merge = [{
              event: 'merge',
              source_branch: @merge_source.id,
              source_deck: @merge_source.head_deck,
              time: Time.now.iso8601
            }].to_json
            
            Branch.where(id: @merge_base.id).update_all(["merge_history = merge_history || ?::jsonb", new_merge])
           
           
           flash[:success] = 'Branch was merged.'
           redirect_to BranchesHelper.PathToBranch(@merge_base)
           
        else
            flash[:warning] = 'Both branches cannot be the same to merge.'
            render "compare"
        end
       
       
    end
    
    def update
        if(@master_deck.branches.where(:name => params['branch']['name']).present?) 
           # branch already exists fail.
           flash[:warning] = 'A branch for this deck with that name already exists.'
           render "new"
        else
            @branch = @master_deck.branches.friendly.find(params['branch_id'])
            
            @branch.update(name: params['branch']['name'], is_public: params['branch']['is_public'])
            
            redirect_to BranchesHelper.PathToBranch(@branch)
        end
    end
    
    def delete
        unless(@master_deck.branches.friendly.find(params['branch_id']).present?) 
           # branch already exists fail.
           flash[:warning] = 'This branch to delete does not exist.'
           render "new"
        else
            @branch = @master_deck.branches.friendly.find(params['branch_id'])
            
            @branch.update(deleted: true)
            flash[:warning] = 'Branch was successfully deleted.'
            redirect_to MasterDecksHelper.PathToMasterDeck(@master_deck)
        end
    end
    
    private
    
    def set_master_deck
        if params.has_key?(:user_id)
            @master_deck = User.friendly.find(params[:user_id]).master_decks.friendly.find(params[:master_deck_id])
        else 
            @master_deck = current_user.master_decks.friendly.find(params[:master_deck_id])
        end
    end
    
    
end
