require 'rails_helper'

describe 'Listings API' do
  context 'listings#index' do 
    context 'happy path' do 
      before(:each) do 
        @user1 = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        create_list(:user, 5)
        create_list(:plant, 10)
        create_list(:listing, 10)

        get '/api/v1/listings', params: { user_id: @user1.id }
      end

      it 'has a successful response' do 
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'returns a json of expected data' do 
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(data.keys).to eq([:id, :type, :attributes])
      end
      
      it 'attributes match expected JSON contract' do 
        listings = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
        
        listings.each do |listing|
          expect(listing.keys).to eq([:listing_id, :active, :quantity, :category, :rooted, :plant_id, :user_id, :description, :plant])
        end
      end
      
      it 'attributes return as expected data types' do 
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:type]).to eq("listings")
        expect(json[:data][:attributes]).to be_an Array

        json[:data][:attributes].each do |listing|
          # Listing Data for all listings returned in array
          expect(listing).to be_a Hash
          expect(listing[:listing_id]).to be_an Integer
          expect(listing[:plant_id]).to be_a Integer
          expect(listing[:user_id]).to be_a Integer
          expect(listing[:active].class).to eq(TrueClass) | eq(FalseClass)
          expect(listing[:quantity]).to be_an Integer
          expect(listing[:category]).to be_a String
          expect(listing[:rooted].class).to eq(TrueClass) | eq(FalseClass)
          expect(listing[:description]).to be_a String

          # Plant data for each listing returned
          expect(listing[:plant]).to be_a Hash
          expect(listing[:plant][:photo]).to be_a String
          expect(listing[:plant][:plant_type]).to be_a String
          expect(listing[:plant][:indoor].class).to eq(TrueClass) | eq(FalseClass)
        end
      end
    end

    context 'MISSING params' do
      before(:each) do 
        @user1 = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        create_list(:user, 5)
        create_list(:plant, 10)
        create_list(:listing, 10)

        get '/api/v1/listings'
      end

      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end

      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:message]).to eq(":user_id param missing or empty")
      end
    end
    
    context 'EMPTY params' do 
      before(:each) do 
        @user1 = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        create_list(:user, 5)
        create_list(:plant, 10)
        create_list(:listing, 10)
        
        get '/api/v1/listings', params: { user_id: "" }
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:message]).to eq(":user_id param missing or empty")
      end
    end
  end
  
  context 'listings#create' do 
    context 'happy path' do 
  
    end
    
  end
end