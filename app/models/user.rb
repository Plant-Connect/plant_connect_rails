class User < ApplicationRecord
  # Model Validations
  validates_presence_of :email, 
                        :password_digest, 
                        :username
  validates_uniqueness_of :email 
  has_secure_password

  # Model Relationships
  has_many :plants
  has_many :listings
end