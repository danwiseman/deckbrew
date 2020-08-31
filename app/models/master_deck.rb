class MasterDeck < ApplicationRecord
    belongs_to :user
    has_many :branches
    
    extend FriendlyId
    friendly_id :name, :use => :scoped, :scope => :user
    
    validates_presence_of :name
    validates_presence_of :deck_type
    validates_presence_of :is_public
    
    validates :name, uniqueness: { scope: :user }
    
end
