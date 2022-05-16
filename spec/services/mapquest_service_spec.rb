require 'rails_helper'

RSpec.describe MapquestService, :vcr do
  context 'class methods' do 
    context '#get_city_coordinates(city)' do
      before(:each) do 
        @location_data = MapquestService.get_city_coordinates('St. Louis, MO')
      end

      it 'returns a hash of location data' do 
        expect(@location_data).to be_a Hash
      end

      it 'hash has expected data' do 
        expect(@location_data.keys).to eq([:lat, :lng])
      end

      it 'latitude and longitude are returned as a Float' do 
        expect(@location_data[:lat]).to be_a Float
        expect(@location_data[:lat]).to eq(38.630276)
        
        expect(@location_data[:lng]).to be_a Float
        expect(@location_data[:lng]).to eq(-90.200309)
      end
    end

    context '#directions(start, destination)' do
      before(:each) do 
        @route = MapquestService.directions('St. Louis, MO', 'Denver, CO')
      end

      it 'returns a hash of direction data' do 
        expect(@route).to be_a Hash
      end

      it 'hash has expected data' do
        expect(@route.keys).to eq([:route, :info])
      end
    end 
  end
end