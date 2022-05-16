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

      
    end 
  end
end