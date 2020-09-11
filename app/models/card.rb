class Card < ApplicationRecord
    
    
    
    
    validates_presence_of :oracle_name
    validates_presence_of :scryfall_id
    
end
