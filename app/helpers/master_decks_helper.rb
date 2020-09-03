module MasterDecksHelper
    
    
    def self.PathToMasterDeck(master_deck)
        UsersHelper.PathToUser(master_deck.user) + '/decks/' +  master_deck.slug
    end
    
    def master_deck_with_privacy_badge(master_deck, is_linked=false)
        output = ""
        if is_linked
            output = tag.a href: MasterDecksHelper.PathToMasterDeck(master_deck) do
                master_deck.name
            end
        else
            output = master_deck.name
        end
        output += " "
        if master_deck.is_public?
            output += tag.span "Public", class: "badge badge-success"
        else
            output += tag.span "Private", class: "badge badge-default"
        end
        output.html_safe
    end
end
