Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://:password@127.0.0.1:6379/10' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://:password@127.0.0.1:6379/10' }
end
