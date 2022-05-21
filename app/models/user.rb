class User < ApplicationRecord
  # Model Validations
  validates_presence_of :email, 
                        :password_digest, 
                        :username, 
                        :location
  validates_uniqueness_of :email 
  has_secure_password

  # Model Relationships
  has_many :plants, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :user_conversations
  has_many :conversations, through: :user_conversations
end