class Branch < ApplicationRecord
    belongs_to :master_deck
    has_many :decks
    
    store_accessor :branched_from, :source_branch, :source_deck

    
    extend FriendlyId
    friendly_id :name, :use => :scoped, :scope => :master_deck
    
    validates_presence_of :name
    
    
    
end
