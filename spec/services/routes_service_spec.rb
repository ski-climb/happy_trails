require 'rails_helper'

describe 'Routes Service' do
  context '.new' do
    it 'instantiates with token and connection' do
      token = '3f0981341'
      service = RoutesService.new(token)

      expect(service.token).to eq token
      expect(service.conn).to be_a Faraday::Connection
    end
  end

  context '.recent_routes(token)' do
    context 'valid token' do
      it 'returns 3 most recent polylines', vcr: true do
        routes = RoutesService.recent_routes(ENV['ACCESS_TOKEN'])

        expect(routes).to be_a Array
        expect(routes.count).to eq 3
        expect(routes.first).to be_a String
      end
    end
    
    context 'invalid token' do
      it 'returns empty array', vcr: true do
        routes = RoutesService.recent_routes('invalid_token')

        expect(routes).to be_a Array
        expect(routes.count).to eq 0
      end
    end
  end
end
