require "rails_helper"

require_relative '../support/branch_helpers'
require_relative '../support/master_deck_helpers'
require_relative '../support/user_helpers'

include UserHelpers
include MasterDeckHelpers
include BranchHelpers


describe HistoryHelper do

    describe "#branches_and_merges" do
        it "returns a time stamp ordered list of all the deck history, branching and the merges" do
            user = FactoryBot.create(:user)
            sign_in_via_form(user)
            master_deck = create_master_deck_via_form(user)
            create_many_branches(master_deck)
            
            expect(branches_and_merges(master_deck)).to include(a_hash_including(:name => "branch2"))
        end
    end
    
    describe "#git_graph" do
        
    end
    
    describe "#dashboard_timeline" do
        it "returns a list that is a timeline of all the events on the master_deck" do
            user = FactoryBot.create(:user)
            sign_in_via_form(user)
            master_deck = create_master_deck_via_form(user)
            create_many_branches(master_deck)
           
           expect(dashboard_timeline(master_deck)).to have_text("main was created") 
           expect(dashboard_timeline(master_deck)).to have_text("branch1 was branched from main") 
           expect(dashboard_timeline(master_deck)).to have_text("branch3 was branched from branch1")
        end
    end
    

end