class UserProfile < ApplicationRecord
    belongs_to :user
    
    store_accessor :socialmedia, :twitter, :facebook, :github
    
    after_initialize :init

    def init
        self.tagline ||= "Likes MTG"
        self.default_deck_visibility ||= true
        
    end
    
    
    validates_presence_of :default_deck_visibility
    
end
