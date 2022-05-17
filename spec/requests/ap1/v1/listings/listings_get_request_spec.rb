require 'rails_helper'

describe "get /listings API endpoint" do
  it "returns active listings that a given user has not posted" do
    user1 = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
    create_list(:user, 5)
    create_list(:plant, 10)
    create_list(:listing, 10)
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    get '/api/v1/listings', headers: headers, params: { user_id: user1.id }
    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to be_a Hash
    expect(json[:data]).to be_a Hash
    expect(json[:data][:type]).to eq("listings")
    expect(json[:data][:attributes]).to be_a Array
    json[:data][:attributes].each do |listing|
      expect(listing).to be_a Hash
      expect(listing.keys).to eq([:listing_id, :active, :quantity, :category, :rooted, :plant_id, :description, :plant])
      expect(listing[:listing_id]).to be_a Integer
      # expect(listing[:active].class).to eq(TrueClass || FalseClass)
      expect(listing[:listing_id].class).to_not eq(String)
      expect(listing[:quantity]).to be_a Integer
      expect(listing[:category]).to be_a String
      # expect(listing[:rooted].class).to eq(TrueClass || FalseClass)
      expect(listing[:rooted].class).to_not eq(String)
      expect(listing[:plant_id]).to be_a Integer
      expect(listing[:description]).to be_a String
      expect(listing[:plant]).to be_a Hash
      expect(listing[:plant][:user_id]).to be_a Integer
      expect(listing[:plant][:photo]).to be_a String
      expect(listing[:plant][:plant_type]).to be_a String
      expect(listing[:plant][:indoor].class).to_not eq(String)
      # expect(listing[:plant][:indoor].class).to eq(TrueClass || FalseClass)
    end
  end
end
