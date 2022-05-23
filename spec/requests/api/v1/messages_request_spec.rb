require 'rails_helper'

RSpec.describe 'Messages API', :type => :request do 

  context 'messages#create' do 
    
    context 'happy path' do 

      context 'Creates new conversation and message' do 
        before(:each) do
          @user1 = User.create!(
                                username: 'Steven', 
                                email: 'steven@test.com', 
                                password: 'password123', 
                                password_confirmation: 'password123', 
                                location: 'Denver, CO'
                              )
        
        @user2 = User.create!(
                                username: 'Colton', 
                                email: 'colton@test.com', 
                                password: '123password', 
                                password_confirmation: '123password', 
                                location: 'Denver, CO'
                              )
        
        @plant = @user1.plants.create(
                                        photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', 
                                        plant_type: 'snake plant', 
                                        indoor: true
                                      )
        
        @listing = @user1.listings.create!(
                                            plant_id: @plant.id, 
                                            quantity: 2, 
                                            category: 1, 
                                            description: 'This is the listings description', 
                                            rooted: true, 
                                            active: true
                                          )
        
          @request_body = {
                            "listing_id": @listing.id,
                            "user_id": @user2.id,
                            "message": {
                                        "user_id": @user2.id, 
                                        "content": "I'm very interested in your snake plant."
                                        }
                          }.to_json
  
          headers = { 'CONTENT_TYPE' => 'application/json' }
  
          post "/api/v1/messages", headers: headers, params: @request_body
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
          respone_message = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
  
          expect(respone_message.keys).to eq([:conversation_id, :user_id, :content])
        end
        
        it 'attributes return as expected data types' do 
          json = JSON.parse(response.body, symbolize_names: true)
  
          expect(json).to be_a Hash
          expect(json[:data]).to be_a Hash
          expect(json[:data][:type]).to eq("message")
  
          expect(json[:data][:attributes]).to be_a Hash

          expect(json[:data][:attributes][:conversation_id]).to be_an Integer

          expect(json[:data][:attributes][:user_id]).to be_an Integer
          expect(json[:data][:attributes][:user_id]).to eq(@user2.id)
  
          expect(json[:data][:attributes][:content]).to be_a String
          expect(json[:data][:attributes][:content]).to eq("I'm very interested in your snake plant.")
        end
      end

      
    end
  end
end