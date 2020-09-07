class DecksController < ApplicationController
    
    before_action :authenticate_user!, only: [:edit]
    before_action :set_master_deck_and_current_branch, only: [:edit]
    

    def edit
        
        
        render layout: "dashboard"
    end
    

    private
    
    def set_master_deck_and_current_branch
        @master_deck = current_user.master_decks.friendly.find(params[:master_deck_id])
        @branch = @master_deck.branches.friendly.find(params[:branch_id])
        
    end
    
end
