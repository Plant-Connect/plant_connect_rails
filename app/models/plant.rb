class Plant < ApplicationRecord
  # Model Validations
  validates_presence_of :photo, 
                        :type, 
                        :description, 
                        :user_id
  
  validates :indoor, inclusion: { in: [true, false] }
  
  # Model Relationships
  belongs_to :user
  has_many :listings
end
