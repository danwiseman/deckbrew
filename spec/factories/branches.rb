FactoryBot.define do
  factory :branch do
    name { "main" }
    slug { "main" }
    branched_from { 0 }
    branched_from_deck { 0 }
    
     
    master_deck
    
    after :create do |branch|
      create :deck, branch: branch   # has_one
      
    end
    
  end
end
