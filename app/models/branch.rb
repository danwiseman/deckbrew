class Branch < ApplicationRecord
    belongs_to :master_deck
    has_many :decks
    
    extend FriendlyId
    friendly_id :name, :use => :scoped, :scope => :master_deck
    
end
