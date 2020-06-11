# frozen_string_literal: true

namespace :docker do
  desc 'DESTROY anything in public folder'
  task clobber: :environment do
    FileUtils.rm_rf ['public/*']
  end

  desc 'Flush redis cache'
  task :flush do
    Redis.new.flushall
  end

  desc 'Restart sidekiq as well'
  task restart: :restart do
    system 'pkill -f ^sidekiq'
  end
end
