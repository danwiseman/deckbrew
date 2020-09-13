require "rails_helper"


RSpec.describe MtgCardComponent, type: :component do
  
  it "renders an mtg card of the size requested" do
    expect(
      render_inline(MtgCardComponent.new(scryfall_id: 'fc4d7aa2-ee1b-435c-8876-44111fafc97a', content:'', display_size: 'normal'))
      ).to include(
        ''
        )
  
  end
  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class.new(attr: "value")) { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end
