module BranchesHelper
    
    def self.PathToBranch(branch)
        MasterDecksHelper.PathToMasterDeck(branch.master_deck) + '/branch/' + branch.slug
    end
    
end
