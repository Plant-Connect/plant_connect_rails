require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :category }
    it { should validate_presence_of :description }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :plant_id }

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

      listing = user.listings.create!(plant_id: plant.id, quantity: 2, category: 1, description: 'This is the listings description', rooted: true, active: true)
      
      expect(Listing.last).to eq(listing)
      expect(listing.category).to eq('clippings')
    end
    
    it 'allows category as a string as long as it matches one provided by enum' do 
      user = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')
      plant = user.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
      
      listing = user.listings.create!(plant_id: plant.id, quantity: 2, category: 'seeds', description: 'This is the listings description', rooted: true, active: true)
      
      expect(Listing.last).to eq(listing)
      expect(listing.category).to eq('seeds')
    end
  end
  
  describe 'instance methods' do 
    describe 'send_new_listing_email' do 
      it 'runs mailer method on all users in the same county as listing' do 
        user1 = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
        plant = user1.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
        listing = user1.listings.create!(plant_id: plant.id, quantity: 2, category: 1, description: 'This is the listings description', rooted: true, active: true)
        user2 = User.create(username: 'Brenda', email: 'brenda@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
        user3 = User.create(username: 'Emily', email: 'emily@test.com', password: 'plantconnect', password_confirmation: 'plantconnect', location: 'Denver County, CO')
        user4 = User.create(username: 'Jerry', email: 'jerry@test.com', password: 'madprops', password_confirmation: 'madprops', location: 'Boulder County, CO')
        user5 = User.create(username: 'Katie', email: 'katie_a@test.com', password: 'seedly', password_confirmation: 'seedly', location: 'Jefferson County, CO')     
        
        email_recipients = listing.send_new_listing_email
        
        expect(email_recipients).to eq([user2, user3])
      end
    end
  end
end