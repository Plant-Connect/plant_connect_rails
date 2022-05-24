class ListingSerializer
  include JSONAPI::Serializer

  attributes :active, :quantity, :category, :rooted, :plant_id, :user_id, :description, :plant

  def self.show_listing(listing)
    {
      data: {
        id: nil,
        type: "listing",
        attributes: {
          listing_id: listing.id,
          active: listing.active,
          quantity: listing.quantity,
          category: listing.category,
          rooted: listing.rooted,
          plant_id: listing.plant_id,
          description: listing.description,
          user_id: listing.user_id
        }
      }
    }.to_json
  end

  def self.listing_not_created
    {
      data: {
        id: nil,
        type: "error",
        message: "Invalid or incomplete paramaters provided"
      }
    }
  end
end
