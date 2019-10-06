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

    it 'responds with errors because the username is already taken' do
      create(:user, username: 'thetruenorth')

      post api_users_path, params: params

      expect(response).to have_http_status :unprocessable_entity
      expect(json_response.dig('errors', 'username').join).to match /has already been taken/
    end
  end

  describe 'GET /api/user/:user_id/followers' do
    let(:user) { create(:user) }
    let!(:follower) { create(:follower, user: user, target: build(:user, username: 'thetruenorth')) }
    let!(:other_follower) { create(:follower, user: user, target: build(:user, username: 'ygrittethewild')) }

    it 'returns the two followers' do
      get api_user_followers_path(user)

      expect(response).to have_http_status :ok
      expect(json_response.dig('data').count).to eq 2
      expect(json_response.dig('data').map{ |user| user.dig('attributes', 'username') }).to contain_exactly('thetruenorth', 'ygrittethewild')
    end
  end

  describe 'POST /api/users/:user_id/follow/:id' do
    let(:user) { create(:user) }
    let(:target) { create(:user) }

    it 'returns a 404 if the user is not found' do
      post api_user_follow_path('1234', target.id)

      expect(response).to have_http_status :not_found
      expect(json_response.dig('errors', 'message')).to match /Couldn't find User with 'id'/
      expect(json_response.dig('errors', 'object_not_found')).to eq 'user'
    end

    it 'returns a 404 if the target is not found' do
      post api_user_follow_path(user.id, '1234')

      expect(response).to have_http_status :not_found
      expect(json_response.dig('errors', 'message')).to match /Couldn't find User with 'id'/
      expect(json_response.dig('errors', 'object_not_found')).to eq 'target'
    end

    it 'returns an error if the user already follows the target' do
      create(:follower, user: user, target: target)

      post api_user_follow_path(user.id, target.id)

      expect(response).to have_http_status :unprocessable_entity
      expect(json_response.dig('errors')).to eq 'user already follows target'
    end

    it 'follows the target and returns 200' do
      post api_user_follow_path(user.id, target.id)

      expect(response).to have_http_status :ok
    end
  end

  describe 'POST /api/users/:user_id/unfollow/:id' do
    let(:user) { create(:user) }
    let(:target) { create(:user) }

    it 'returns a 404 if the user is not found' do
      post api_user_unfollow_path('1234', target.id)

      expect(response).to have_http_status :not_found
      expect(json_response.dig('errors', 'message')).to match /Couldn't find User with 'id'/
      expect(json_response.dig('errors', 'object_not_found')).to eq 'user'
    end

    it 'returns a 404 if the target is not found' do
      post api_user_unfollow_path(user.id, '1234')

      expect(response).to have_http_status :not_found
      expect(json_response.dig('errors', 'message')).to match /Couldn't find User with 'id'/
      expect(json_response.dig('errors', 'object_not_found')).to eq 'target'
    end

    it 'returns an error if the user does not follow the target' do

      post api_user_unfollow_path(user.id, target.id)

      expect(response).to have_http_status :unprocessable_entity
      expect(json_response.dig('errors')).to eq "user didn't follow target"
    end

    it 'unfollows the target and returns 200' do
      create(:follower, user: user, target: target)

      post api_user_unfollow_path(user.id, target.id)

      expect(response).to have_http_status :ok
    end
  end
end
