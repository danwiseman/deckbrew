require "rails_helper"

describe BranchesHelper do

    describe "#PathToBranch" do
        it "returns a link to the branch's view page" do
            branch = FactoryBot.create(:branch)
            
            expect(BranchesHelper.PathToBranch(branch)).to match /u\/.*?\/decks\/.*?\/branch\/.*/ 
        end
    end

end