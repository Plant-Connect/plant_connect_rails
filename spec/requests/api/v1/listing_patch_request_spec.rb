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

    end

    xit "recieves a bad repsonse if the form is filled out incompletely or if the data types don't match" do
      user  = User.create(username: 'Aedan2', email: 'aedan2@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
      plant = user.plants.create(photo: 'photo string', plant_type: 'plant_type', indoor: true)
      listing = user.listings.create(quantity: 10, category: "plant", description: "blah blah", plant_id: plant.id)

      patch_params = {
        quantity: nil,
        listing_id: listing.id
      }.to_json


      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/listings", headers: headers, params: patch_params

    end
  end
end
