class Listing < ApplicationRecord
  # Model Validations
  before_validation :set_default_rooted
  validates_presence_of :quantity,
                        :category,
                        :description,
                        :user_id,
                        :plant_id
  validates_numericality_of :quantity
  # validates :rooted, inclusion: { in: [true, false] }
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
    where(active: true)
    .where.not(user_id: user_id)
    .order('listings.created_at DESC')
  end

    private

      def set_default_rooted
        if self.category == "plant"
          self.rooted = true
        elsif self.category == "seeds"
          self.rooted = false
        end
      end
end
