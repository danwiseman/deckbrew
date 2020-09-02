require "rails_helper"

describe SymbolsHelper do
  describe "#mtgSymbol" do
    
    it "returns an <i> tag with the correct classes and options" do
       expect(mtgSymbol('{U}', shadow: true)).to eq("<i class=\"ms ms-u ms-cost ms-shadow \"></i>") 
    
    end    
    
    it "returns the text as is if it is not a proper symbol" do
         expect(mtgSymbol('black', shadow: true)).to eq("black") 
    end
    
  end
  
  describe "#prettyMtgText" do
  
    it "returns text with <i> tags of the correct mana and set symbols" do
        expect(prettyMtgText("<p>This is a long HTML passage, but it includes {U} and {B} symbols</p>")).to match /<i class=\"ms ms-u ms-cost \"><\/i>/
    end
        

  end
  
  
  describe "#mtgSetSymbol" do
    it "returns an <i> tag with the correct classes and options" do
        expect(mtgSetSymbol('soi')).to eq("<i class=\"ss ss-soi ss-common \"></i>") 
    end  
      
  end
  
  
end