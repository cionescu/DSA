require 'rails_helper'

RSpec.describe Api::SearchController, type: :request do
  it "queries the endpoint" do
    VCR.use_cassette('query for student loan') do
      get '/api/search', params: { "q" => "student loan" }

      expect(response).to have_http_status :ok
      expect(json_response.count).to eq 1
      expect(json_response.dig(0, "text")).to match /Student finance/
      expect(json_response.dig(0, "language")).to eq "en"
    end
  end

  it "gets a welsh response" do
    VCR.use_cassette('query for chwyddiant') do
      get '/api/search', params: { "q" => "chwyddiant" }

      expect(response).to have_http_status :ok
      expect(json_response.count).to eq 1
      expect(json_response.dig(0, "language")).to eq "cy"
    end
  end

  it "returns a 404", vcr: true do
    VCR.use_cassette('get a 404') do
      get '/api/search', params: { "q" => "cucumbers" }

      expect(response).to have_http_status :not_found
      expect(json_response).to be_blank
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
