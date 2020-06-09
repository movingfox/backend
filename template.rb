# frozen_string_literal: true

def source_paths
  [__dir__]
end

copy_file 'Procfile', 'Procfile'
directory 'bin', 'bin', force: true
directory 'config', 'config', force: true
directory 'db', 'db', force: true

insert_into_file 'config/application.rb', after: /6\.0\n/ do
  <<-RUBY
    config.time_zone = 'Taipei'
    config.i18n.available_locales = [:en, 'zh-TW']
    config.i18n.default_locale = 'zh-TW'
    config.i18n.fallbacks = true
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]

    config.active_job.queue_adapter = :sidekiq

    # Customize generators
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :slim
      g.helper          false
      g.test_framework  :minitest, spec: false
    end
  RUBY
end

inject_into_file 'config/database.yml', after: /pool:.*\n/ do
  <<-RUBY
  host: localhost
  username: postgres
  password: docker
  RUBY
end

inject_into_file 'config/database.yml', after: /_production\n/ do
  <<-RUBY
  host:     <%= ENV['POSTGRES_HOST'] %>
  database: <%= ENV['POSTGRES_DB'] %>
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASSWORD'] %>
  RUBY
end

apply 'gemfile.rb'

after_bundle do
  run 'rails generate friendly_id'
  run 'rails generate trestle:install'
  run 'rails generate trestle:auth:install Administrator'
  run 'rails generate devise:install'
  run 'rails generate devise User'
  inject_into_file 'config/initializers/devise.rb', after: /config\.secret_key.*\n/ do
    <<-RUBY
  config.secret_key = Rails.application.credentials.secret_key_base
    RUBY
  end
  run 'rails generate komponent:install'
  git :init
  git add: '.'
  git commit: %( -m 'Initial commit' )
end
