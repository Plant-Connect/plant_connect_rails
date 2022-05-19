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
      render json: { data: { message: 'user_id param missing or empty' } }, status: 400
    else
      plant = @user.plants.create(plant_params)
      listing = plant.listings.create(listing_params)
  
      if listing.save
        render json: ListingSerializer.show_listing(listing), status: 201
      else
        render json: ListingSerializer.listing_not_created, status: 400
      end
    end 
  end

  def update
    if params[:listing_id].blank?
      render json: { data: { message: 'user_id param missing or empty' } }, status: 400
    else
      listing = Listing.find(params[:listing_id])
      if listing.update(listing_params)
        render json: ListingSerializer.show_listing(listing), status: 202
      else
        render json: ListingSerializer.no_update(listing), status: 400
      end
    end
  end

    private
      def listing_params
        params.permit(:quantity, :category, :user_id, :description, :plant_id, :active, :rooted)
      end

      def plant_params
        params.permit(:photo, :plant_type, :indoor)
      end

      def find_user
        @user = User.find_by_id(params[:user_id])
      end
end
