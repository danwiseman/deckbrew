class UsersController < ApplicationController
    
    before_action :authenticate_user!, only: [:index]
    
    def index
        redirect_to "/u/#{current_user.slug}"
        
    end
    
    
    def show
        
    end
end
