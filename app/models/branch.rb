class Branch < ApplicationRecord
    belongs_to :master_deck
    has_many :decks
    
    store_accessor :history, :branched_from, :merges
    
    extend FriendlyId
    friendly_id :name, :use => :scoped, :scope => :master_deck
    
    validates_presence_of :name
    
    
end
