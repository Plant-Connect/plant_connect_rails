class ListingSenderJob
  include Sidekiq::Job

  def perform(recipient_id, listing_id)
    UserNotifierMailer.send_listing_email(recipient_id, listing_id).deliver_now
  end
end
