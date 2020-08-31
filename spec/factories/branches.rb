FactoryBot.define do
  factory :branch do
    name { "master" }
    slug { "master" }
     
    master_deck
    
    after :create do |branch|
      create :deck, branch: branch   # has_one
      
    end
    
  end
end
