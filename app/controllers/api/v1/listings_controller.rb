class Api::V1::ListingsController < ApplicationController
  before_action :find_user, only: [:create]

  # There will be some code we need to include on the Create whenever we are saving a new listing in order to send the email notifications to Users. The line of code is below.
  # This method will need the ID of the objects to be passed as the `perform` function does NOT pass through objects and will convert any argument into a serialize-able string.
  # <listing_object>.send_new_listing_email(@listing)

  def index
    # return all active listings (excluding users own listings)
    if params[:user_id].present?
      listings = Listing.active_listings_self_excluded(params[:user_id])
      render json: ListingSerializer.listings(listings, params[:user_id])
    else
      render json: { data: { message: 'user_id param missing or empty' } }, status: 400
    end
  end

  def create
    if params[:user_id].blank?
      json_response({ data: { message: 'user_id param missing or empty' } }, :bad_request)
    else
      plant = @user.plants.create(plant_params)

      if plant.save
        listing = plant.listings.create(listing_params)

        if listing.save
          listing.send_new_listing_email
          json_response(ListingSerializer.show_listing(listing), :created)
        else
          json_response(ListingSerializer.listing_not_created, :bad_request)
        end
      else 
        json_response(ListingSerializer.listing_not_created, :bad_request)
      end
    end 
  end

  def update
    if params[:listing_id].blank?
      json_response({ data: { message: 'listing_id is missing or blank' } }, :bad_request)
    elsif params[:listing].blank?
      json_response({ data: { message: 'Invalid or incomplete paramaters provided. Listing not updated' } }, :bad_request)
    else
      listing = Listing.find(params[:listing_id])
      if listing.update(listing_params)
        json_response(ListingSerializer.show_listing(listing), :accepted)
      else
        json_response({ data: { message: 'Invalid or incomplete paramaters provided. Listing not updated' } }, :bad_request)
      end
    end
  end

    private
      def listing_params
        params.require(:listing).permit(:quantity, :category, :user_id, :description, :plant_id, :active, :rooted)
      end

      def plant_params
        params.permit(:photo, :plant_type, :indoor)
      end

      def find_user
        @user = User.find_by_id(params[:user_id])
      end
end
