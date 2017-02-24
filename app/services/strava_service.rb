class StravaService

  attr_reader :token, :conn

  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://www.strava.com/api/v3/athlete/activities") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.recent_routes(token)
    new(token).recent_routes
  end

  def recent_routes
    response = conn.get do |req|
      req.params['access_token'] = token
      req.params['per_page']     = 3
    end
    raw_routes = JSON.parse(response.body)
    summary_polylines(raw_routes) rescue []
  end

  def summary_polylines(raw_routes)
    raw_routes.map { |raw_route| raw_route['map']['summary_polyline'] }
  end
end
