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
        expect(json[:data][:message]).to eq("user_id param missing or empty")
      end
    end
    
    context 'EMPTY/BLANK params' do 
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
        expect(json[:data][:message]).to eq("user_id param missing or empty")
      end
    end
  end


  
  context 'listings#create' do 
    
    context 'happy path' do 
      before(:each) do 
        @user = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        @plant = @user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
        
        @listing_params = {
                            user_id: @user.id,
                            plant_id: @plant.id,
                            quantity: 5,
                            category: 2,
                            description: 'This is the listings description'
                          }.to_json

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/listings", headers: headers, params: @listing_params
      end

      it 'has a successful response' do 
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end

      it 'returns a json of expected data' do 
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(data.keys).to eq([:id, :type, :attributes])
      end
      
      it 'attributes match expected JSON contract' do 
        listing = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

        expect(listing.keys).to eq([:listing_id, :active, :quantity, :category, :rooted, :plant_id, :description, :user_id])
      end
      
      it 'attributes return as expected data types' do 
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:type]).to eq("listing")

        expect(json[:data][:attributes]).to be_a Hash
        expect(json[:data][:attributes][:listing_id]).to be_an Integer

        expect(json[:data][:attributes][:active].class).to eq(TrueClass)
        expect(json[:data][:attributes][:active]).to be true 
        
        expect(json[:data][:attributes][:quantity]).to be_an Integer
        expect(json[:data][:attributes][:quantity]).to eq(5)

        expect(json[:data][:attributes][:category]).to be_a String
        expect(json[:data][:attributes][:category]).to eq("plant")

        expect(json[:data][:attributes][:rooted].class).to eq(TrueClass)
        expect(json[:data][:attributes][:rooted]).to be true

        expect(json[:data][:attributes][:plant_id]).to be_an Integer
        expect(json[:data][:attributes][:plant_id]).to eq(@plant.id)

        expect(json[:data][:attributes][:user_id]).to be_an Integer
        expect(json[:data][:attributes][:user_id]).to eq(@user.id)
      end
    end

    context 'MISSING params' do
      before(:each) do 
        @user = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        @plant = @user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
      
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/listings", headers: headers
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:type]).to eq('error')
        expect(json[:data][:message]).to eq("Invalid or incomplete paramaters provided")
      end
    end
    
    context 'EMPTY/BLANK params' do 
      before(:each) do 
        @user = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        @plant = @user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
        
        @listing_params = {
                            
                          }.to_json

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/listings", headers: headers, params: @listing_params
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:type]).to eq('error')
        expect(json[:data][:message]).to eq("Invalid or incomplete paramaters provided")
      end
    end

    context 'INCOMPLETE params' do 
      before(:each) do 
        @user = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
        @plant = @user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
        
        @listing_params = {
                            user_id: @user.id,
                            plant_id: @plant.id,
                            category: 2,
                            description: 'This is the listings description'
                          }.to_json

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/listings", headers: headers, params: @listing_params
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:type]).to eq('error')
        expect(json[:data][:message]).to eq("Invalid or incomplete paramaters provided")
      end
    end
  end

  context 'listings#update' do 
    context 'happy path' do 
      before(:each) do 
        @user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
        @plant = @user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
        @listing = @user.listings.create(quantity: 10, category: 2, description: "blah blah", plant_id: @plant.id)

        @patch_params = {
          active: false,
          quantity: 20,
          listing_id: @listing.id
        }.to_json

        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch "/api/v1/listings", headers: headers, params: @patch_params
      end

      it 'has a successful response' do 
        expect(response).to be_successful
        expect(response).to have_http_status(202)
      end

      it 'returns a json of expected data' do 
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(data.keys).to eq([:id, :type, :attributes])
      end
      
      it 'attributes match expected JSON contract' do 
        listing = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

        expect(listing.keys).to eq([:listing_id, :active, :quantity, :category, :rooted, :plant_id, :description, :user_id])
      end
      
      it 'attributes return as expected data types' do 
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:type]).to eq("listing")

        expect(json[:data][:attributes]).to be_a Hash
        expect(json[:data][:attributes][:listing_id]).to be_an Integer

        expect(json[:data][:attributes][:active].class).to eq(FalseClass)
        expect(json[:data][:attributes][:active]).to be false 
        
        expect(json[:data][:attributes][:quantity]).to be_an Integer
        expect(json[:data][:attributes][:quantity]).to eq(20)

        expect(json[:data][:attributes][:category]).to be_a String
        expect(json[:data][:attributes][:category]).to eq("plant")

        expect(json[:data][:attributes][:rooted].class).to eq(TrueClass)
        expect(json[:data][:attributes][:rooted]).to be true

        expect(json[:data][:attributes][:plant_id]).to be_an Integer
        expect(json[:data][:attributes][:plant_id]).to eq(@plant.id)

        expect(json[:data][:attributes][:user_id]).to be_an Integer
        expect(json[:data][:attributes][:user_id]).to eq(@user.id)
      end
    end

    context 'MISSING params' do
      before(:each) do 
        @user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
        @plant = @user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
        @listing = @user.listings.create(quantity: 10, category: 2, description: "blah blah", plant_id: @plant.id)

        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch "/api/v1/listings", headers: headers
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:message]).to eq("user_id param missing or empty")
      end
    end
    
    context 'EMPTY/BLANK params' do 
      before(:each) do 
        @user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
        @plant = @user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
        @listing = @user.listings.create(quantity: 10, category: 2, description: "blah blah", plant_id: @plant.id)

        @patch_params = {
        }.to_json

        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch "/api/v1/listings", headers: headers, params: @patch_params
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:message]).to eq("user_id param missing or empty")
      end
    end

    # context 'INCOMPLETE params' do 
    #   before(:each) do 
    #     @user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
    #     @plant = @user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
    #     @listing = @user.listings.create(quantity: 10, category: 2, description: "blah blah", plant_id: @plant.id)

    #     @patch_params = {
    #       active: false,
    #       quantity: 20,
    #       listing_id: @listing.id
    #     }.to_json

    #     headers = { 'CONTENT_TYPE' => 'application/json' }
    #     patch "/api/v1/listings", headers: headers, params: @patch_params
    #   end
      
      # it 'returns a 400 error code' do 
      #   expect(response.status).to eq(400)
      # end
    
      # it 'returns error message for invalid params' do 
      #   json = JSON.parse(response.body, symbolize_names: true)
    
      #   expect(json).to be_a Hash
      #   expect(json[:data]).to be_a Hash
      #   expect(json[:data][:type]).to eq('error')
        # expect(json[:data][:attributes][:message]).to eq("Invalid or incomplete paramaters provided. Listing not updated")
      # end
    # end
  end
end