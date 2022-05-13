class Listing < ApplicationRecord
  validates_presence_of :quantity, :category
  validates_numericality_of :quantity
  validates :rooted, inclusion: { in: [true, false] }
  
  belongs_to :user
  belongs_to :plant

  # enum category: [:seeds, :clippings, :plant]
end
