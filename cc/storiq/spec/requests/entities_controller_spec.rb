require 'rails_helper'

RSpec.describe EntitiesController, type: :request do
  let!(:region) { create(:entity, :region) }
  let!(:area) { create(:entity, :area, parent: region) }
  let!(:region_review) { create(:review, entity: region, score: 5) }
  let!(:area_review) { create(:review, entity: area, score: 3) }

  it "shows the entities on the page" do
    get '/'

    # the outer card should show the region
    outer_card = html_response.css("body .card").first
    expect(outer_card.css("h3").first.inner_text.squish).to match /#{region.name} \( REGION/

    #inside there should be another card with the area
    inner_card = outer_card.css(".card")
    expect(inner_card.css("h3").first.inner_text.squish).to match /#{area.name} \( AREA/
  end

  it "shows the reviews" do
    get '/'

    first_title = html_response.css("body .card h3").first.inner_text.squish
    expect(first_title).to match /Average: 5.0/
    expect(first_title).to match /Average including children: 4.0/
  end
end
