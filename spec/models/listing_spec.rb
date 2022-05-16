require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :category }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :plant_id }
    it { should validate_presence_of :description }


    it { should validate_numericality_of :quantity }
  end

  describe 'relationships' do 
    it { should belong_to :user }
    it { should belong_to :plant }
  end

  describe 'enumerable' do 
    it 'converts category from integer to related category' do 
      user = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')
      plant = user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)

      listing = user.listings.create!(plant_id: plant.id, quantity: 2, category: 1, description: 'This is the listings description', rooted: true)

      expect(Listing.last).to eq(listing)
      expect(listing.category).to eq('clippings')
    end
    
    it 'allows category as a string as long as it matches one provided by enum' do 
      user = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')
      plant = user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
  
      listing = user.listings.create!(plant_id: plant.id, quantity: 2, category: 'seeds', description: 'This is the listings description', rooted: true)
      
      expect(Listing.last).to eq(listing)
      expect(listing.category).to eq('seeds')
    end
  end
end