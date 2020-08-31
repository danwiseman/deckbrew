module MasterDecksHelper
    
    
    def self.PathToMasterDeck(master_deck)
        '/u/' + master_deck.user.slug + '/decks/' +  master_deck.slug
    end
end
