class UserNotifierMailer < ApplicationMailer

  def send_listing_email(recipient_id, listing_id)

    @recipient = User.find_by_id(recipient_id)
    @listing = Listing.find_by_id(listing_id)

    @recipient_email = @recipient.email
    @recipient_name = @recipient.username

    mail( :to => @recipient_email, 
          :subject => 'New plant listings in your area!')
  end
end