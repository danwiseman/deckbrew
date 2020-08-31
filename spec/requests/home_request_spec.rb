require 'rails_helper'

RSpec.describe "Homes", type: :request do
    
    it "shows a splash style screen when visitor is not logged in" do
        get "/"
        expect(response).to render_template(:index)
        
        expect(response.body).to include("Welcome to Deck Brew")
        
        
    end
    


end
