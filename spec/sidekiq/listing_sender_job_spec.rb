require 'rails_helper'

RSpec.describe ListingSenderJob do
  describe 'perform' do
    it 'qeues a job to send emails' do 
      user1 = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
      plant = user1.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
      listing = user1.listings.create!(plant_id: plant.id, quantity: 2, category: 1, description: 'This is the listings description', rooted: true, active: true)
      user2 = User.create(username: 'Brenda', email: 'brenda@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
      
      expect {
        ListingSenderJob.perform_async(user2.id, listing.id)
      }.to change(ListingSenderJob.jobs, :size).by(1)
      
      
      expect(ListingSenderJob).to have_enqueued_sidekiq_job(user2.id, listing.id)
    end
    
    it 'sends the email when job is performed' do 
      user1 = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
      plant = user1.plants.create(photo: 'https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg', plant_type: 'snake plant', indoor: true)
      listing = user1.listings.create!(plant_id: plant.id, quantity: 2, category: 1, description: 'This is the listings description', rooted: true, active: true)
      user2 = User.create(username: 'Brenda', email: 'brenda@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
      
      ListingSenderJob.new.perform(user2.id, listing.id)

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end 