Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://:p747d795ec49db166d901f210bbcbfcb6247f0ab7971da3d28fde9a77ff13fd77@ec2-34-203-181-194.compute-1.amazonaws.com:30899' }
end