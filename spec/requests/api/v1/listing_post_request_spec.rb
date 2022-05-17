require 'rails_helper'

RSpec.describe "Listing POST/Create", type: :request do
  describe "When a user sends proper info in a form and attempts to post a new Listing," do
    it "sends a successful response if form was filled out properly" do

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

      require "pry"; binding.pry
      expect(json).to be_a Hash

    end

    it "sends back a json response with all necessary info" do

    end

    it "sends an unsuccesful response if form filled out improperly, or incomplete" do

    end
  end
end
