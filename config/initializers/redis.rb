# uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
# REDIS = Redis.new(:url => uri)

 module MyApp
   class << self
     def redis
       @redis ||= Redis.new(url: (ENV['REDISTOGO_URL'] || 'redis://127.0.0.1:6379'))
     end
   end
 end
