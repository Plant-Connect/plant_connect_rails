class Listing < ApplicationRecord
  # Model Validations
  validates_presence_of :quantity, 
                        :category, 
                        :user_id, 
                        :description, 
                        :plant_id
  validates_numericality_of :quantity
  validates :rooted, inclusion: { in: [true, false] }

  # Model Relationships
  belongs_to :user
  belongs_to :plant

  enum category: [:seeds, :clippings, :plant]
end
