class UsersController < ApplicationController
    
    before_action :authenticate_user!, only: [:index, :edit]
    
    def index
        redirect_to "/u/#{current_user.slug}"
        
    end
    
    
    def show
        @profile_user = User.friendly.find(params[:id])
        
        render layout: "dashboard"
    end
    
    def edit
        @user_profile = current_user.user_profile
        render layout: "dashboard"
    end
    
    def update
       current_user.user_profile.update(tagline: params['user_profile']['tagline'], 
                        default_deck_visibility: params['user_profile']['default_deck_visibility'],
                        twitter: params['user_profile']['twitter'], facebook: params['user_profile']['facebook'],
                        github: params['user_profile']['github']) 
       redirect_to "/u/#{current_user.slug}"
    end
end
