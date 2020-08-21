require "rails_helper"
require_relative "../support/devise"

RSpec.describe MasterDecksController, type: :controller do
    
    describe "GET /" do
        
        context "A visitor goes to the root of the decks pages" do
            it "should respond with 200:OK" do 
                get :index
                expect(response).to have_http_status(:success)
            end
        end
    end
    
end