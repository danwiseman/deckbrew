class UserProfile < ApplicationRecord
    belongs_to :user
    
    
    after_initialize :init

    def init
        self.tagline ||= "Likes MTG"
        self.default_deck_visibility ||= true
        
    end
    
end
