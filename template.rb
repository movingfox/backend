# frozen_string_literal: true

def source_paths
  [__dir__]
end

directory 'bin', 'bin', force: true
directory 'config', 'config', force: true
directory 'db', 'db', force: true
directory 'lib', 'lib', force: true
copy_file 'Guardfile', 'Guardfile'
copy_file 'Procfile', 'Procfile'
copy_file '.rubocop', '.rubocop'
copy_file '.rubocop.yml', '.rubocop.yml'
copy_file '.gitignore', 'gitignore'

insert_into_file 'config/application.rb', after: /'rails\/all'\n/ do
  <<~RUBY
    require 'view_component/engine'
  RUBY
end

insert_into_file 'config/application.rb', after: /6\.0\n/ do
  <<-RUBY
    config.time_zone = 'Taipei'

    config.action_cable.mount_path = '/cable'
    config.active_job.queue_adapter = :sidekiq

    # Customize generators
    config.generators do |g|
      g.orm             :active_record
      g.helper          false
      g.test_framework  :minitest, spec: false
    end

    # Fix the compatibility problem with wicked_pdf
    config.view_component.render_monkey_patch_enabled = false # defaults to true
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

inject_into_file 'config/routes.rb', after: /do\n/ do
  <<-RUBY
  resources :csp_reports, only: %i[create]
  RUBY
end

apply 'gemfile.rb'

insert_into_file 'app/assets/config/manifest.js', after: /\.css\n/ do
  <<~RUBY
    //= link trestle/sidekiq.css
  RUBY
end

after_bundle do
  run 'rails generate annotate:install'
  run 'rails generate erd:install'
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
  run "rails generate model csp_report blocked_uri:string disposition:string \
       document_uri:string effective_directive:string violated_directive:string \
       referrer:string status_code:integer raw_report:jsonb raw_browser:string "
  run 'rails stimulus_reflex:install'
  run 'rails generate stimulus_reflex user'
  run 'brakeman'
  run 'rubocop -a'
#  git :init
#  git add: '.'
#  git commit: %( -m 'Initial commit' )
end
