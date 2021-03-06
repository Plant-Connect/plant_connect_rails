require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :username }
    it { should validate_presence_of :location }
    
    it { should validate_uniqueness_of :email }
    
    it { should have_secure_password }
  end

  describe 'relationships' do 
    it { should have_many :plants }
    it { should have_many :listings }
    it { should have_many :messages }
    it { should have_many :user_conversations }
    it { should have_many(:conversations).through(:user_conversations) }
  end

  describe 'user creation' do 
    it 'encrypts password' do 
      user = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end

    it 'creates a user when email is unique and passwords match' do 
      user = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')
      
      expect(user).to be_instance_of User
      expect(User.last.email).to eq(user.email)
    end
    
    it 'does not create a User when email is already taken' do 
      user1 = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')
      user2 = User.create(username: 'Steven', email: 'steven@test.com', password: 'anotherpassword', password_confirmation: 'anotherpassword', location: 'Denver, CO')
      
      expect(User.count).to eq(1)
      expect(user1).to be_instance_of User
      expect(User.last.email).to eq(user1.email)
    end
    
    it 'does not create a User when password and confirmation are not matching' do 
      user1 = User.create(username: 'Steven', email: 'steven@test.com', password: 'password123', password_confirmation: 'password123', location: 'St. Louis, MO')
      user2 = User.create(username: 'Steven', email: 'anotheremail@test.com', password: 'anotherpassword', password_confirmation: 'thisisthewrongpassword', location: 'Denver, CO')
      
      expect(User.count).to eq(1)
      expect(user1).to be_instance_of User
      expect(User.last).to eq(user1)
      expect(User.last.email).to eq(user1.email)
    end
  end
end