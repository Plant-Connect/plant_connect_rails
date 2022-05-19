# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end

 Sidekiq.configure_server do |config|

   Rails.logger = Sidekiq::Logging.logger

   config.redis = { :url => MyApp.redis[:url], :namespace => 'sidekiq', :size => 5 }
 end

 Sidekiq.configure_client do |config|
   config.redis = { :url => MyApp.redis[:url], :namespace => 'sidekiq', :size => 1 }
 end