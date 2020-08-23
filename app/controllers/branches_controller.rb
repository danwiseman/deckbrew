class BranchesController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]
    before_action :set_master_deck, only: [:new, :create]
    
    def new
        
        
    end
    
    
    def create
        
        
    end
    
    private
    
    def set_master_deck
        @master_deck = MasterDeck.friendly.find(params[:master_deck_id])
    end
    
end
