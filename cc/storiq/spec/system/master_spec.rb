require 'rails_helper'

RSpec.describe 'Entities Index' do
  let!(:region) { create(:entity, :region) }
  let!(:area) { create(:entity, :area, parent: region) }
  let!(:region_review) { create(:review, entity: region, score: 5) }
  let!(:area_review) { create(:review, entity: area, score: 3) }

  before do
    driven_by :selenium_chrome_headless
    Capybara.default_selector = :css
  end

  it "shows the entities on the page" do
    visit '/'

    # the outer card should show the region
    outer_card = html_response.css("body .card").first
    expect(outer_card.css("h3").first.inner_text.squish).to match /#{region.name} \( REGION/

    #inside there should be another card with the area
    inner_card = outer_card.css(".card")
    expect(inner_card.css("h3").first.inner_text.squish).to match /#{area.name} \( AREA/
  end

  it "shows the reviews" do
    visit '/'

    first_title = html_response.css("body .card h3").first.inner_text.squish
    expect(first_title).to match /Average: 5.0/
    expect(first_title).to match /Average including children: 4.0/
  end

  it "creates a new area nested under region" do
    visit '/'

    inner_card = html_response.css("body .card .card").first
    # Sanity check
    expect(inner_card.css("h3").first.inner_text.squish).to match /AREA/

    # Create the new area
    within("body .card #new_entity[data-parent-id='#{region.id}']") do
      fill_in 'entity_name', with: "My New Area"
      select "AREA", from: "entity_entity_type"
      click_on 'save'
    end

    expect(page).to have_text("The entity was successfully created")
    expect(Entity.last.name).to eq "My New Area"
  end

  it "creates a review" do
    visit '/'

    within("body .card #new_review[data-parent-id='#{region.id}'") do
      select '4', from: 'review_score'
      fill_in 'review_title', with: 'The best and original review'
      click_on 'save'
    end

    expect(page).to have_text("The review has been successfully posted")

    last_review = Review.last
    expect(last_review.score).to eq 4
    expect(last_review.title).to eq "The best and original review"
    expect(last_review.entity).to eq region

    # Also check that the new review is displayed on the page

    outer_card = html_response.css("body .card").first
    expect(outer_card.inner_text.squish).to match /4 | The best and original review/
  end
end
