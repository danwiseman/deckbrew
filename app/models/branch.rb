class Branch < ApplicationRecord
    belongs_to :master_deck
    has_many :decks
    
    extend FriendlyId
    friendly_id :name, :use => :scoped, :scope => :master_deck
    
    validates_presence_of :name
    validates_presence_of :branched_from
    validates_presence_of :branched_from_deck
    
end
