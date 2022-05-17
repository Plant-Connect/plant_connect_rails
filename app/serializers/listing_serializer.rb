class ListingSerializer
  def self.listings(listings, user_id)
    {
      "data": {
          "id": nil,
          "type": "listings",
          "attributes": listings.map do |listing|
            {
              "listing_id": listing.id,
              "active": listing.active,
              "quantity": listing.quantity,
              "category": listing.category,
              "rooted": listing.rooted,
              "plant_id": listing.plant_id,
              "description": listing.description,
              "plant": {
                  "user_id": listing.plant.user_id,
                  "photo": listing.plant.photo,
                  "plant_type": listing.plant.plant_type,
                  "indoor": listing.plant.indoor
              }
            }
          end
      }
  }
  end

  def self.show_listing(listing)
    {
      data: {
        id: nil,
        type: "listing",
        attributes: {
          listing_id: listing.id,
          active: true,
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
        type: "listing",
        attributes: {
          description: "Form not filled out all the way, Please try again"
        }
      }
    }
  end

  def self.no_update(listing)
    {
      data: {
        id: nil,
        type: "listing",
        attributes: {
          description: "Form filled out incorrectly, Listing was not updated",
          listing_id: listing.id
        }
      }
    }
  end
end
