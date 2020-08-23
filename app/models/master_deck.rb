class MasterDeck < ApplicationRecord
    belongs_to :user
    has_many :decks
    
    extend FriendlyId
    friendly_id :name, use: :slugged
end
