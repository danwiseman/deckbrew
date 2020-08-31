FactoryBot.define do
  factory :branch do
    name { "master" }
    slug { "master" }
    master_deck
  end
end
