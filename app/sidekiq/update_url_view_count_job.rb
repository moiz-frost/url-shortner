class UpdateUrlViewCountJob
  include Sidekiq::Job

  def perform
    redis = Service::Redis.client
    key_wildcard = 'Url:*:view_count'

    redis.keys(key_wildcard).each do |key|
      pending_count = redis.get(key)
      redis.decrby(key, pending_count.to_i)
      id = key.split(':')[1]
      Url.find_by_id(id)&.increment! :view_count, pending_count.to_i
    end
  end
end
