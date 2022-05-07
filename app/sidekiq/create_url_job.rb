class CreateUrlJob
  include Sidekiq::Job

  def perform(count = 1000)
    count.times do
      UrlService::Create.call
    end
  end
end
