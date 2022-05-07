require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CreateUrlJob, type: :job do
  include ActiveJob::TestHelper

  context 'perform_async' do
    it 'enqueues job correctly' do
      expect do
        CreateUrlJob.perform_async
      end.to change(CreateUrlJob.jobs, :size).by(1)
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
      expect(CreateUrlJob.jobs.size).to eq 1

      Timecop.travel(10.minutes.from_now)

      expect(CreateUrlJob.jobs.size).to eq 1

      Timecop.travel(10.days.from_now)
    end
  end

  context 'url creation every minute' do
    before do
      @redis = Service::Redis.client
    end

    it 'should create 1000 unused urls when the job runs' do
      key = Constants::GLOBAL_URL_COUNTER_KEY

      expect(@redis.get(key).to_i).to eq 0

      CreateUrlJob.perform_sync

      expect(Url.count).to eq 1000
      expect(Url.unused.count).to eq 1000
      expect(@redis.get(key).to_i).to eq 1000
    end

    it 'should create 100 unused urls when the job runs with count argument' do
      key = Constants::GLOBAL_URL_COUNTER_KEY

      expect(@redis.get(key).to_i).to eq 0

      CreateUrlJob.perform_sync 100

      expect(Url.count).to eq 100
      expect(Url.unused.count).to eq 100
      expect(@redis.get(key).to_i).to eq 100
    end
  end
end
