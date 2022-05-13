require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password_digest }
    
    it { should validate_uniqueness_of :email }
    
    it { should have_secure_password }
  end

  describe 'user creation' do 
    it 'encrypts password' do 
      user = User.create(email: 'steven@test.com', password: 'password123', password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end

    it 'creates a user when email is unique and passwords match' do 
      user = User.create(email: 'steven@test.com', password: 'password123', password_confirmation: 'password123')
      
      expect(user).to be_instance_of User
      expect(User.last.email).to eq(user.email)
    end
    
    it 'does not create a User when email is already taken' do 
      user1 = User.create(email: 'steven@test.com', password: 'password123', password_confirmation: 'password123')
      user2 = User.create(email: 'steven@test.com', password: 'anotherpassword', password_confirmation: 'anotherpassword')
      
      expect(User.count).to eq(1)
      expect(user1).to be_instance_of User
      expect(User.last.email).to eq(user1.email)
    end
    
    it 'does not create a User when password and confirmation are not matching' do 
      user1 = User.create(email: 'steven@test.com', password: 'password123', password_confirmation: 'password123')
      user2 = User.create(email: 'anotheremail@test.com', password: 'anotherpassword', password_confirmation: 'thisisthewrongpassword')
      
      expect(User.count).to eq(1)
      expect(user1).to be_instance_of User
      expect(User.last).to eq(user1)
      expect(User.last.email).to eq(user1.email)
    end
  end
end