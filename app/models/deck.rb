class Deck < ApplicationRecord
    belongs_to :branch
    
    validates_presence_of :version
    validates_presence_of :previousversion
    
end
