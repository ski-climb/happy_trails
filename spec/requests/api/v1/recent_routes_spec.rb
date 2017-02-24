require 'rails_helper'

describe 'Recent Routes API' do
  context 'logged in user with valid token' do
    it 'returns users 3 most recent routes', vcr: true do
      user = create(:user, token: ENV['ACCESS_TOKEN'])
      stub_user(user)

      get "/api/v1/users/#{user.id}/recent_routes"
      routes = JSON.parse(response.body)

      expect(response).to be_success
      expect(routes).to be_an Array
      expect(routes.count).to eq 3
      expect(routes.first).to be_a String
    end
  end

  context 'logged in user with invalid token' do
    it 'returns empty array', vcr: true do
      user = create(:user, token: 'invalid_token')
      stub_user(user)

      get "/api/v1/users/#{user.id}/recent_routes"
      routes = JSON.parse(response.body)

      expect(routes).to be_an Array
      expect(routes.count).to eq 0
    end
  end

  context 'invalid user id' do
    it 'returns 404' do
      get "/api/v1/users/1/recent_routes"

      expect(response.status).to eq 404
    end
  end
end