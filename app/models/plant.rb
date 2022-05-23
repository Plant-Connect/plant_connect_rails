class Plant < ApplicationRecord
  include Rails.application.routes.url_helpers

  # Model Validations
  validates_presence_of :plant_type,
                        :user_id
                        # temporarily commented out photo validation in order to attach cloudinary photo url to plant after creation
                        # :photo
  
  validates :indoor, inclusion: { in: [true, false] }
  
  # Model Relationships
  belongs_to :user
  has_many :listings, dependent: :destroy
  # not a DB attribute like :photo
  has_one_attached :image

  # url_for comes from our include on line 2, we may want to implement it in our serializer once we
  # get to the point where we're uploading to cloudinary

  # def get_image_url
  #   url_for(self.image)
  # end
end
