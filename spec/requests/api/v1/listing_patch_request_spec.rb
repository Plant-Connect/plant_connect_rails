require 'rails_helper'

RSpec.describe "Listing Patch/Create", type: :request do
  describe "when a user submits a patch request" do
    it "recieves a successful response with a json object and all pertninent information" do
      user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
      plant = user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
      listing = user.listings.create(quantity: 10, category: "plant", description: "blah blah", plant_id: plant.id)

      patch_params = {
        quantity: 20,
        listing_id: listing.id
      }.to_json

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/listings", headers: headers, params: patch_params

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
      expect(json[:data][:attributes][:category]).to eq("plant")
      expect(json[:data][:attributes][:rooted]).to eq(true)
      expect(json[:data][:attributes][:plant_id]).to eq(plant.id)
      expect(json[:data][:attributes][:user_id]).to eq(user.id)

      expect(json[:data][:attributes][:quantity]).to_not eq(10)
    end

    it "recieves a bad repsonse if the form is filled out incompletely or if the data types don't match" do
      user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
      plant = user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
      listing = user.listings.create(quantity: 10, category: "plant", description: "blah blah", plant_id: plant.id)

      patch_params = {
        quantity: nil,
        listing_id: listing.id
      }.to_json


      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/listings", headers: headers, params: patch_params

      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

    end
  end
end
