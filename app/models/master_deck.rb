class MasterDeck < ApplicationRecord
    belongs_to :user
    has_many :branches
    
    extend FriendlyId
    friendly_id :name, :use => :scoped, :scope => :user
end
