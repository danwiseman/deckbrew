require 'rails_helper'

RSpec.describe UserProfile, type: :model do
   
    it "is valid with valid attributes" do 
        user = FactoryBot.create(:user)
        up = UserProfile.new(user: user, default_deck_visibility: true)
        expect(up).to be_valid
    end
    it "is not valid without a default_deck_visibility" do
        up = UserProfile.new(default_deck_visibility: nil)
        expect(up).to_not be_valid
    end
    it "is not valid without a user" do
       up = UserProfile.new(user: nil)
       expect(up).to_not be_valid
    end
  
end
