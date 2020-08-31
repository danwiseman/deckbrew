FactoryBot.define do
  factory :deck do
    branch
    version { Faker::Number.number(digits: 3) }
    previousversion { Faker::Number.number(digits: 4) }
    
  end
  
end
