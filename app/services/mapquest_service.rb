class MapquestService

  def self.conn 
    Faraday.new(url: 'http://www.mapquestapi.com/') do |faraday|
      faraday.params['key'] = ENV['mapquest_key']
    end
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