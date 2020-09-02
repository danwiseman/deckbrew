module MasterDecksHelper
    
    
    def self.PathToMasterDeck(master_deck)
        UsersHelper.PathToUser(master_deck.user) + '/decks/' +  master_deck.slug
    end
end
