class Api::V1::ListingsController < ApplicationController

  # There will be some code we need to include on the Create whenever we are saving a new listing in order to send the email notifications to Users. The line of code is below.
  # This method will need the ID of the objects to be passed as the `perform` function does NOT pass through objects and will convert any argument into a serialize-able string.
  # ListingSenderJob.perform_async(@user2.id, @listing.id)

  def index
    # return all active listings (excluding users own listings)
    listings = Listing.active_listings_self_excluded(params[:user_id])
    render json: ListingSerializer.listings(listings,params[:user_id])
  end

  def create
    listing = Listing.create(listing_params)
    if listing.save
      render json: ListingSerializer.create_listing(listing)
    else
      render json: ListingSerializer.listing_not_created, status: 400
    end
  end

    private
      def listing_params
        params.permit(:quantity, :category, :user_id, :description, :plant_id, :active, :rooted)
      end
end
