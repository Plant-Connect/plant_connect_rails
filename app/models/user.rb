class User < ApplicationRecord
  validates_presence_of :email, :password_digest, :username
  validates_uniqueness_of :email 
  
  has_secure_password

  has_many :plants
end