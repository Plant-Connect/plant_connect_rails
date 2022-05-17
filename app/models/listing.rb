class Listing < ApplicationRecord
  # Model Validations

  validates_presence_of :quantity, 
                        :category, 
                        :description, 
                        :user_id, 
                        :plant_id
  validates_numericality_of :quantity
  validates :rooted, inclusion: { in: [true, false] }
  validates :active, inclusion: { in: [true, false] }

  # Model Relationships
  belongs_to :user
  belongs_to :plant

  enum category: [:seeds, :clippings, :plant]

  def send_new_listing_email
    recipients = User.where(location: user.location).where.not(id: user.id)
    recipients.each do |recipient|
      ListingSenderJob.perform_async(recipient.id, self.id)
    end
  end

  def self.active_listings_self_excluded(user_id)
    select("listings.*")
    .where(listings: {active: true})
    .where.not(listings: {user_id: user_id})
    .group('listings.id')
    .order('listings.created_at DESC')
  end
end
