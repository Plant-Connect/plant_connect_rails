class ListingsController < ApplicationController

  # There will be some code we need to include on the Create whenever we are saving a new listing in order to send the email notifications to Users. The line of code is below. 
  # This method will need the ID of the objects to be passed as the `perform` function does NOT pass through objects and will convert any argument into a serialize-able string. 
  # ListingSenderJob.perform_async(@listing.id)
  # <listing_object>.send_new_listing_email(@listing)
 
end