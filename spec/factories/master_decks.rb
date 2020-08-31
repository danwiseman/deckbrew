FactoryBot.define do
  factory :master_deck do
    name { Faker::Book.title }
    user
    deck_type { Faker::Coffee.variety } 
    is_public { true }
    description { Faker::Coffee.notes }
    
    after :create do |master_deck|
      create :branch, master_deck: master_deck   # has_one
    end
    
  end

end
