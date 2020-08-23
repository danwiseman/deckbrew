FactoryBot.define do
  factory :branch do
    name { Faker::Book.title }
    master_deck
  end
end
