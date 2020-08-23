class Deck < ApplicationRecord
    belongs_to :master_deck
    
    extend FriendlyId
    friendly_id :branchname, :use => :scoped, :scope => :master_deck
end
