class UserNotifierMailer < ApplicationMailer

  def send_listing_email(email, listing)
    @email = email 
    mail( :to => @email, 
          :subject => 'New plant listings in your area!')
  end
end