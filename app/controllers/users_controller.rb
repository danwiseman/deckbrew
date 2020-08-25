class UsersController < ApplicationController
    
    before_action :authenticate_user!, only: [:index, :edit]
    
    def index
        redirect_to "/u/#{current_user.slug}"
        
    end
    
    
    def show
        @profile_user = User.friendly.find(params[:id])
    end
    
    def edit
        
        
    end
end
