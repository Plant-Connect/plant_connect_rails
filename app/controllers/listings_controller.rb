class ListingsController < ApplicationController
  def index 
    Listing.destroy_all
    Plant.destroy_all
    User.destroy_all
    @user1 = User.create!(
        username: 'Steven', 
        email: 'steven@test.com', 
        password: 'password123', 
        password_confirmation: 'password123'
      )
      
      @user2 = User.create!(
        username: 'Aedan', 
        email: 'aedan@test.com', 
        password: '123password', 
        password_confirmation: '123password'
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
        rooted: true
      )

      ListingSenderJob.perform_async(@user2.id, @listing.id)
      json_response([@listing]) 
  end
end