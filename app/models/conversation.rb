class Conversation < ApplicationRecord
  before_validation :set_name 

  validates_presence_of :listing_id, :name

  has_many :user_conversations
  has_many :users, through: :user_conversations
  has_many :messages

  belongs_to :listing

  private 

    def set_name
      self.name = listing.plant.plant_type
    end
end
