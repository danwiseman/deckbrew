require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CardsHelper. For example:
#
# describe CardsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CardsHelper, type: :helper do
  
    describe "#cardDisplay" do
        it "takes a scryfall uuid and returns the requested card in a div" do
           scryfall_uuid = "ee40c471-70c8-4171-a214-ce932c4c7e2e"
           
           expect(cardDisplay(scryfall_uuid)).to have_content("<img src=\"https://c1.scryfall.com/file/scryfall-cards/normal/front/e/e/ee40c471-70c8-4171-a214-ce932c4c7e2e.jpg?1576384695\" />")
        end
        
        it "shows two sided cards as flippable"
        
        
        
    
    end
  
  
end
