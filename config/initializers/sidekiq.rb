Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = 'config/schedule.yml'

    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
  end

  redis_config = Rails.application.credentials[:redis]
  config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  redis_config = Rails.application.credentials[:redis]
  config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/#{Rails.env}" }
end
