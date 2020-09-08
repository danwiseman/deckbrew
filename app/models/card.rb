class Card < ApplicationRecord
    
    
    store_accessor :scryfall_data, :set
    
    validates_presence_of :oracle_name
    validates_presence_of :scryfall_id
    
end
