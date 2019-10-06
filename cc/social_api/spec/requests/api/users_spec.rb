require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/users' do
    let(:params) {{
      user: {
        name: 'John Snow',
        username: 'thetruenorth'
      }
    }}
    it 'creates a user' do
      post api_users_path, params: params

      expect(response).to have_http_status :ok
      expect(json_response.dig('data', 'attributes', 'name')).to eq 'John Snow'
      expect(json_response.dig('data', 'attributes', 'username')).to eq 'thetruenorth'
    end
  end
end
