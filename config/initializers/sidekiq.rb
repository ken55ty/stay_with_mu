require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  schedule_file = 'config/schedule.yaml'
  config.redis = {
    url: ENV.fetch('REDIS_URL', nil)
  }

  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch('REDIS_URL', nil)
  }
end
