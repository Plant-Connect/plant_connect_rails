class Plant < ApplicationRecord
  validates_presence_of :photo, :type, :description
  validates :indoor, inclusion: { in: [true, false] }
  
  belongs_to :user

end
