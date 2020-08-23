FactoryBot.define do
  factory :master_deck do
    name { Faker::Book.title }
    path { "#{name.parameterize('-')}" }
    user
    
  end

end
