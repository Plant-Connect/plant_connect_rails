require 'rails_helper'

RSpec.describe "Listing POST/Create", type: :request do
  describe "When a user sends proper info in a form and attempts to post a new Listing," do
    it "sends a successful response if form was filled out properly, and has all proper info in a json object" do

      user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
      plant = user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
      listing_params = {
        quantity: 20,
        category: :clippings,
        user_id: user.id,
        rooted: true,
        description: "this is a plant clipping please have it for free",
        plant_id: plant.id
                       }.to_json

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/listings", headers: headers, params: listing_params

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json[:data]).to be_a Hash
      expect(json[:data][:type]).to eq("listing")
      expect(json[:data][:attributes]).to be_a Hash
      expect(json[:data][:attributes][:listing_id]).to be_a Integer
      expect(json[:data][:attributes][:active]).to eq(true)
      expect(json[:data][:attributes][:quantity]).to be_a Integer
      expect(json[:data][:attributes][:quantity]).to eq(20)
      expect(json[:data][:attributes][:category]).to be_a String
      expect(json[:data][:attributes][:category]).to eq("clippings")
      expect(json[:data][:attributes][:rooted]).to eq(true)
      expect(json[:data][:attributes][:plant_id]).to eq(plant.id)
      expect(json[:data][:attributes][:user_id]).to eq(user.id)
    end

    it "sends an unsuccesful response if form filled out improperly, or incomplete" do

    end
  end
end
