class DecksController < ApplicationController
    
    before_action :authenticate_user!, only: [:edit]

    def edit
        
        
        render layout: "dashboard"
    end
    


    
end
