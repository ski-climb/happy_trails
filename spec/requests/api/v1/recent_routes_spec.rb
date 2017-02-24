require 'rails_helper'

describe 'Users API' do
  context 'logged in user with valid token' do
    it 'returns users 3 most recent routes', vcr: true do
      user = create(:user, token: ENV['ACCESS_TOKEN'])
      login_user(user)

      get "/api/v1/recent_routes"
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
      login_user(user)

      get "/api/v1/recent_routes"
      routes = JSON.parse(response.body)

      expect(routes).to be_an Array
      expect(routes.count).to eq 0
    end
  end

  context 'guest visitor' do
    it 'returns 404' do
      get "/api/v1/recent_routes"

      expect(response.status).to eq 404
    end
  end
end