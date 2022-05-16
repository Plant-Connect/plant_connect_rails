class MapquestService

  def self.conn 
    Faraday.new(url: 'http://www.mapquestapi.com/') do |faraday|
      faraday.params['key'] = ENV['mapquest_key']
    end
  end

  def self.get_city_coordinates(city)
    response = conn.get('geocoding/v1/address') do |request|
      request.params['location'] = city
      request.params['outFormat'] = 'json'
    end
    json = JSON.parse(response.body, symbolize_names: true)[:results][0][:locations][0][:latLng]
  end
  
  def self.directions(start, destination)
    response = conn.get('directions/v2/route') do |request|
      request.params['from'] = start
      request.params['to'] = destination
      request.params['outFormat'] = 'json'
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end
end