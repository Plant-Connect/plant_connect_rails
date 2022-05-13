class User < ApplicationRecord
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email 
  
  has_secure_password
  
end
