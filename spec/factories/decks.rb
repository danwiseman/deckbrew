FactoryBot.define do
  factory :deck do
    branchname { 'master' }
    master_deck
  end
  
  factory :branched_deck do
    branchname { 'new branch' }
    master_deck
  end
end
