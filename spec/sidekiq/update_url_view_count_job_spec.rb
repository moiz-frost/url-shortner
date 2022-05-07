require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe UpdateUrlViewCountJob, type: :job do
  include ActiveJob::TestHelper

  context 'perform_async' do
    it 'enqueues job correctly' do
      expect do
        UpdateUrlViewCountJob.perform_async
      end.to change(UpdateUrlViewCountJob.jobs, :size).by(1)
    end
  end

  context 'cron job' do
    before do
      schedule_file = 'config/schedule.yml'

      Timecop.freeze

      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
    end

    after do
      Timecop.return
    end

    it 'enqueues job' do
      expect(UpdateUrlViewCountJob.jobs.size).to eq 1

      Timecop.travel(10.minutes.from_now)

      expect(UpdateUrlViewCountJob.jobs.size).to eq 1

      Timecop.travel(10.days.from_now)
    end
  end

  context 'increment url view counts' do
    before do
      @url1 = create(:url)
      @url2 = create(:url)
      @redis = Service::Redis.client
    end

    it 'increments view counts in redis and url object' do
      key_wildcard = 'Url:*:view_count'

      expect(@url1.view_count).to eq 0
      expect(@url2.view_count).to eq 0

      expect(@redis.keys(key_wildcard).count).to eq 0

      create(:url_view, url: @url1)
      create(:url_view, url: @url1)
      create(:url_view, url: @url1)

      create(:url_view, url: @url2)
      create(:url_view, url: @url2)
      create(:url_view, url: @url2)
      create(:url_view, url: @url2)
      create(:url_view, url: @url2)

      key1 = "Url:#{@url1.id}:view_count"
      key2 = "Url:#{@url2.id}:view_count"

      expect(@redis.keys(key_wildcard).count).to eq 2
      expect(@redis.keys(key_wildcard)).to match [key1, key2]

      expect(@redis.get(key1).to_i).to eq 3
      expect(@redis.get(key2).to_i).to eq 5

      UpdateUrlViewCountJob.perform_sync

      expect(@redis.get(key1).to_i).to eq 0
      expect(@redis.get(key2).to_i).to eq 0

      expect(@url1.reload.view_count).to eq 3
      expect(@url2.reload.view_count).to eq 5
    end
  end
end
