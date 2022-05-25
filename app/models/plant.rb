class Plant < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Model Validations
  validates_presence_of :plant_type,
                        :user_id,
                        :photo
  
  validates :indoor, inclusion: { in: [true, false] }
  
  # Model Relationships
  belongs_to :user
  has_many :listings, dependent: :destroy
end
