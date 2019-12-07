Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:3003/0' }
  schedule_file = "config/schedule.yaml"
  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end
  
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:3003/0' }
end