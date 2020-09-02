require 'faker'
FactoryBot.define do
    factory :user do 
        username { Faker::Internet.unique.username }
        email { Faker::Internet.unique.email }
        password { 'test1234' }
    end
    
    factory :slugged_user, parent: :user do
        slug { Faker::Twitter.screen_name }
    end

end