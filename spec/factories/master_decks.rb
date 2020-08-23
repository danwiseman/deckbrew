FactoryBot.define do
  factory :master_deck do
    name { Faker::Book.title }
    user
    
  end

end
