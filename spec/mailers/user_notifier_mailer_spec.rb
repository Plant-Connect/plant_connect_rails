require 'rails_helper'

RSpec.describe UserNotifierMailer, type: :mailer do
  describe 'send_listing_email' do

    before(:each) do 
      @user1 = User.create!(
        username: 'Steven', 
        email: 'steven@test.com', 
        password: 'password123', 
        password_confirmation: 'password123', 
        location: 'Denver, CO'
      )
      
      @user2 = User.create!(
        username: 'Aedan', 
        email: 'aedan@test.com', 
        password: '123password', 
        password_confirmation: '123password', 
        location: 'Denver, CO'
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
        rooted: true, 
        active: true
      )
      
    end
    
    it 'renders the headers' do
      mail = UserNotifierMailer.send_listing_email(@user2.id, @listing.id).deliver_now
      
      expect(mail.subject).to eq('New plant listings in your area!')
      expect(mail.to).to eq(['aedan@test.com'])
      expect(mail.from).to eq(['planty.raid@yahoo.com'])
    end
    
    it 'renders the body' do
      mail = UserNotifierMailer.send_listing_email(@user2.id, @listing.id).deliver_now

      expect(mail.text_part.body.to_s).to include('Hi Aedan,')
      expect(mail.text_part.body.to_s).to include('Check out the newest listing from Plant Connect!')
      expect(mail.text_part.body.to_s).to include('snake plant')
      expect(mail.text_part.body.to_s).to include('https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg')
      expect(mail.text_part.body.to_s).to include('This is the listings description')
      
      expect(mail.html_part.body.to_s).to include('Hi Aedan,')
      expect(mail.html_part.body.to_s).to include('Check out the newest listing from Plant Connect!')
      expect(mail.html_part.body.to_s).to include('snake plant')
      expect(mail.html_part.body.to_s).to include('https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg')
      expect(mail.html_part.body.to_s).to include('This is the listings description')
      
      expect(mail.body.encoded).to include('Hi Aedan,')
      expect(mail.body.encoded).to include('Check out the newest listing from Plant Connect!')
      expect(mail.body.encoded).to include('snake plant')
      expect(mail.body.encoded).to include('https://user-images.githubusercontent.com/91357724/168396277-da1c9486-fbe9-4e9f-8fb7-68ed88e42489.jpeg')
      expect(mail.body.encoded).to include('This is the listings description')
    end
    
    it 'sends the email' do 
      # expect the email has not been sent. 
      expect(ActionMailer::Base.deliveries.count).to eq(0)

      # send email
      UserNotifierMailer.send_listing_email(@user2.id, @listing.id).deliver_now

      # expect the email has been sent
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    
  end
end