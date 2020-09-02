FactoryBot.define do
  factory :branch do
    name { "main" }
    slug { "main" }
    source_branch { 0 }
    source_deck { 0 }
    
     
    master_deck
    
    after :create do |branch|
      create :deck, branch: branch   # has_one
      
    end
    
  end
end
