class RoutesService

  def self.recent_routes(token)
    new(token).recent_routes
  end

  def recent_routes
    response = conn.get { |req| req.params['access_token'] = token }
    raw_routes = JSON.parse(response.body)[0..2]
    summary_polylines(raw_routes) rescue []
  end

  private

    attr_reader :token, :conn

    def initialize(token)
      @token = token
      @conn = Faraday.new(url: "https://www.strava.com/api/v3/athlete/activities") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end


    def summary_polylines(raw_routes)
      raw_routes.map { |raw_route| raw_route['map']['summary_polyline'] }
    end
end
