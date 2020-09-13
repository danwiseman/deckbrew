class MtgCardComponent < ViewComponent::Base
  def initialize(scryfall_id:, content:, display_size:)
    @scryfall_id = scryfall_id
    @content = content
    @display_size = display_size
    
    @card = Card.snatch(uuid: scryfall_id)
    
    @background_image = @card.image
    
  end
end
