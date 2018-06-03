require 'rails_helper'

RSpec.describe EntitiesController, type: :request do
  let!(:region) { create(:entity, :region) }
  let!(:area) { create(:entity, :area, parent: region) }

  it "shows the entities on the page" do
    get '/'

    # the outer card should show the region
    outer_card = html_response.css("body .card").first
    expect(outer_card.css("h3").first.inner_text.squish).to match /#{region.name} \( REGION/

    #inside there should be another card with the area
    inner_card = outer_card.css(".card")
    expect(inner_card.css("h3").first.inner_text.squish).to match /#{area.name} \( AREA/
  end
end
