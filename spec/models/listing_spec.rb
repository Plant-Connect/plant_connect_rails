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

  describe 'class methods' do 
    describe '#active_listings_self_excluded' do 
      it 'returns all active listings, excluding listings a user has posted' do 
        User.destroy_all
        Plant.destroy_all
        Listing.destroy_all
        user1 = User.create(username: 'Katie', email: 'katie_a@test.com', password: '123password', password_confirmation: '123password', location: 'Denver, CO')
        user2 = User.create(username: 'Brenda', email: 'brenda@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver, CO')
        plant1 = Plant.create(photo: "plant_photo.jpg", plant_type: "monsterra", indoor: true, user_id: user1.id)
        plant2 = Plant.create(photo: "plant_photo.jpg", plant_type: "pothos", indoor: true, user_id: user1.id)
        plant3 = Plant.create(photo: "plant_photo.jpg", plant_type: "philodendron", indoor: true, user_id: user2.id)
        listing1 = Listing.create(quantity: 1, category: 'plant', rooted: true, user_id: user1.id, plant_id: plant1.id, description: "A really nice plant", active: true)
        listing2 = Listing.create(quantity: 1, category: 'plant', rooted: true, user_id: user2.id, plant_id: plant2.id, description: "A nice plant", active: true)
        listing3 = Listing.create(quantity: 3, category: 'plant', rooted: true, user_id: user2.id, plant_id: plant3.id, description: "Some plants", active: true)
        expect(Listing.active_listings_self_excluded(user1.id)).to eq([listing3, listing2])
        expect(Listing.active_listings_self_excluded(user1.id)).to_not eq([listing1, listing2, listing3])
      end
    end
  end
end