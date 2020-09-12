class Card < ApplicationRecord
    
    #
    # Gets a card using the name, set, or scryfall id. It will grab it from scryfall if
    # one exists
    #
    def self.snatch(options = {})
        options = {uuid: nil, name: nil, set: nil}.merge(options)
        cards = nil
        
        if (options[:uuid].nil?)    
            # check cards table for existance
            if (options[:name].nil?)
                return nil
            elsif (options[:set].nil?)
                cards = Card.where(:oracle_name => options[:name])
            else
               cards = Card.where(:oracle_name => options[:name], :set => options[:set])
            end
        else
           cards = Card.where(:scryfall_id => options[:uuid])
        end
       # if it exists, return the uuid
       unless cards.empty?
           card = cards.first
           # if it exists, but has not been updated in 2 weeks...
           if(card.updated_at < (Time.now - 2.weeks)) 
                card = create_from_scryfall(uuid: card.scryfall_id, name: card.oracle_name, set: card.set)
           end
           
           return card
       # OR if it does not exist
       else
            # Grab the details from Scryfall
             card = create_from_scryfall(uuid: options[:uuid], name: options[:name], set: options[:set])
             return card
       end
       # return nil if there are any errors
       return nil
    end
    
    
    private
    
    # returns a card object after grabbing it from scryfall
    def self.create_from_scryfall(options = {})
        options = {uuid: nil, name: nil, set: nil}.merge(options)

        
        uri_search = "https://api.scryfall.com/cards/"
        q = ""
        
        if options[:uuid].present?
            # if uuid is not nil, update the card
            q = options[:uuid]
        elsif options[:set].present?
            # if set is valid, grab the specific card
            q = "search?order=set&q=%21%22#{options[:name]}%22&e%3A#{options[:set]}'"
        else
            # there's no set specified, so let scryfall just pick one
            q = "search?order=set&q=%21%22#{options[:name]}%22&unique=cards'"
        end
        # return the card that is created/updated
        
        
        page_url = uri_search + q
        uri = URI(page_url)
        response = Net::HTTP.get_response(uri)
        if response.kind_of? Net::HTTPSuccess
            data = JSON.parse(response.body)
            
            new_cards = Array.new

            
            if data.key?('data')
                data['data'].each do |card_json|
                    if(Card.where(:scryfall_id => card_json['id']).present?)
                        
                         newCard = Card.where(:scryfall_id => card_json['id']).first
                         newCard.update(:oracle_name => card_json['name'], :set => card_json['set'], :scryfall_data => card_json)
                    else    
                        
                        newCard = Card.create(:scryfall_id => card_json['id'], :oracle_name => card_json['name'], :set => card_json['set'], :scryfall_data => card_json)
                    end
                    new_cards << newCard
                end
            else
                if(Card.where(:scryfall_id => data['id']).present?)
                     newCard = Card.where(:scryfall_id => data['id']).first
                     newCard.update(:oracle_name => data['name'], :set => data['set'], :scryfall_data => data)
                else    
                    newCard = Card.create(:scryfall_id => data['id'], :oracle_name => data['name'], :set => data['set'], :scryfall_data => data)
                end
                new_cards << newCard
                
            end
            
            return new_cards.last
        end
        return nil
    end
    
    
    validates_presence_of :oracle_name
    validates_presence_of :scryfall_id
    
end
