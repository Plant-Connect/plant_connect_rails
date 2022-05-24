require 'rails_helper'

RSpec.describe 'Conversations API', :type => :request do 

  context 'Conversation#index' do 
    
    context 'happy path' do 
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
        @user3 = User.create!(
                                username: 'Ashley', 
                                email: 'ashley@test.com', 
                                password: '456password', 
                                password_confirmation: '456password', 
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
        @conversation1 = Conversation.create!()
        @conversation2 = Conversation.create!()

        @user1convo1 = UserConversation.create(user_id: @user1.id, conversation_id: @conversation1.id)
        @user1convo2 = UserConversation.create(user_id: @user1.id, conversation_id: @conversation2.id)
        @user2convo1 = UserConversation.create(user_id: @user2.id, conversation_id: @conversation1.id)
        @user3convo2 = UserConversation.create(user_id: @user3.id, conversation_id: @conversation2.id)

        @message1 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Thats a nice plant.')
        @message2 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Can I have it?')
        @message3 = Message.create!(user_id: @user3.id, conversation_id: @conversation2.id, content: 'Sweet snake plant.')
        @message4 = Message.create!(user_id: @user1.id, conversation_id: @conversation1.id, content: 'Of course')
  
        get '/api/v1/conversations', params: { user_id: @user1.id }
      end

      it 'has a successful response' do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'returns a json of expected data' do 
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        data.each do |convo|
          expect(convo.keys).to eq([:id, :type, :attributes])
        end
      end
      
      it 'returns all conversations and all messages for each' do 
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(data.count).to eq(Conversation.count)

        expect(data[0][:id]).to eq(@conversation1.id.to_s)
        expect(data[1][:id]).to eq(@conversation2.id.to_s)
        
        expect(data[0][:attributes][:messages].count).to eq(@conversation1.messages.count)
        expect(data[1][:attributes][:messages].count).to eq(@conversation2.messages.count)
      end
      
      it 'attributes match expected JSON contract' do 
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        data.each do |convo|
          expect(convo[:attributes].keys).to eq([:messages])

          convo[:attributes][:messages].each do |message|
            expect(message.keys).to eq([:id, :content, :user_id, :created_at, :updated_at, :conversation_id])
          end
        end
      end
      
      it 'attributes return as expected data types' do 
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json[:data]).to be_an Array

        json[:data].each do |data|
          expect(data).to be_a Hash
          expect(data[:id]).to be_a String
          expect(data[:type]).to eq("conversation")
          expect(data[:attributes]).to be_a Hash
          expect(data[:attributes][:messages]).to be_an Array

          data[:attributes][:messages].each do |message| 
            expect(message[:id]).to be_an Integer
            expect(message[:content]).to be_a String
            expect(message[:user_id]).to be_an Integer
            expect(message[:created_at]).to be_a String
            expect(message[:updated_at]).to be_a String
            expect(message[:conversation_id]).to be_an Integer
          end
        end 
      end
    end

    context 'MISSING user_id' do 
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
        @user3 = User.create!(
                                username: 'Ashley', 
                                email: 'ashley@test.com', 
                                password: '456password', 
                                password_confirmation: '456password', 
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
        @conversation1 = Conversation.create!()
        @conversation2 = Conversation.create!()

        @user1convo1 = UserConversation.create(user_id: @user1.id, conversation_id: @conversation1.id)
        @user1convo2 = UserConversation.create(user_id: @user1.id, conversation_id: @conversation2.id)
        @user2convo1 = UserConversation.create(user_id: @user2.id, conversation_id: @conversation1.id)
        @user3convo2 = UserConversation.create(user_id: @user3.id, conversation_id: @conversation2.id)

        @message1 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Thats a nice plant.')
        @message2 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Can I have it?')
        @message3 = Message.create!(user_id: @user3.id, conversation_id: @conversation2.id, content: 'Sweet snake plant.')
        @message4 = Message.create!(user_id: @user1.id, conversation_id: @conversation1.id, content: 'Of course')
  
        get '/api/v1/conversations'
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:message]).to eq("user_id is required to view conversations")
      end
    end
  end 

  context 'Conversation#show' do 
    
    context 'happy path' do 
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
        @conversation1 = Conversation.create!()

        @user1convo1 = UserConversation.create(user_id: @user1.id, conversation_id: @conversation1.id)
        @user2convo1 = UserConversation.create(user_id: @user2.id, conversation_id: @conversation1.id)

        @message1 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Thats a nice plant.')
        @message2 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Can I have it?')
        @message3 = Message.create!(user_id: @user1.id, conversation_id: @conversation1.id, content: 'Of course')
        @message4 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Yippee!')
  
        get "/api/v1/conversations/#{@conversation1.id}", params: { user_id: @user1.id }
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
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(data[:attributes].keys).to eq([:messages])
        expect(data[:attributes][:messages]).to be_an Array

        data[:attributes][:messages].each do |message|
          expect(message.keys).to eq([:id, :content, :user_id, :created_at, :updated_at, :conversation_id])
        end
      end
      
      it 'attributes return as expected data types' do 
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash

        expect(json[:data][:id]).to be_a String

        expect(json[:data][:type]).to be_a String
        expect(json[:data][:type]).to eq('conversation')

        expect(json[:data][:attributes]).to be_a Hash
        expect(json[:data][:attributes][:messages]).to be_an Array

        json[:data][:attributes][:messages].each do |message|
          expect(message[:id]).to be_an Integer
          expect(message[:content]).to be_a String
          expect(message[:user_id]).to be_an Integer
          expect(message[:created_at]).to be_a String
          expect(message[:updated_at]).to be_a String
          expect(message[:conversation_id]).to be_an Integer
        end 
      end
    end

    context 'MISSING user_id' do 
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
        @conversation1 = Conversation.create!()

        @user1convo1 = UserConversation.create(user_id: @user1.id, conversation_id: @conversation1.id)
        @user2convo1 = UserConversation.create(user_id: @user2.id, conversation_id: @conversation1.id)

        @message1 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Thats a nice plant.')
        @message2 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Can I have it?')
        @message3 = Message.create!(user_id: @user1.id, conversation_id: @conversation1.id, content: 'Of course')
        @message4 = Message.create!(user_id: @user2.id, conversation_id: @conversation1.id, content: 'Yippee!')
  
        get "/api/v1/conversations/#{@conversation1.id}"
      end
      
      it 'returns a 400 error code' do 
        expect(response.status).to eq(400)
      end
    
      it 'returns error message for invalid params' do 
        json = JSON.parse(response.body, symbolize_names: true)
    
        expect(json).to be_a Hash
        expect(json[:data]).to be_a Hash
        expect(json[:data][:message]).to eq("user_id and conversation_id are required")
      end
    end

    
  end 
end 
