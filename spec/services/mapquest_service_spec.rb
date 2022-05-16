require 'rails_helper'

RSpec.describe MapquestService, :vcr do
  context 'class methods' do 

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