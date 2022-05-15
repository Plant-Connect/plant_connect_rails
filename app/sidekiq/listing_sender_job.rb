class ListingSenderJob
  include Sidekiq::Job

  def perform(email, listing)
    UserNotifierMailer.send_listing_email(email, listing).deliver_now
  end
end
