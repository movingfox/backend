# frozen_string_literal: true

uncomment_lines 'Gemfile', 'bcrypt'

gem_group :development do
  gem 'annotate'
  gem 'rails-erd'
  gem 'awesome_print'
  gem 'bullet'

  gem 'brakeman', require: false
  gem 'overcommit'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false

  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-livereload', require: false
  gem 'guard-minitest', require: false
  gem 'rack-livereload'

  gem 'better_errors'
  gem 'binding_of_caller'
end

gem_group :development, :test do
  gem 'minitest-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-controller-testing'
end

# Admin
gem 'trestle'
gem 'trestle-auth', github: 'TrestleAdmin/trestle-auth'
gem 'trestle-search'
gem 'trestle-sidekiq', github: 'movingfox/trestle-sidekiq'

# Background processing
gem 'hiredis'
gem 'sidekiq'
gem 'sidekiq-failures'

# Reactive support
gem 'view_component_reflex'

# Operate text files
gem 'front_matter_parser'
gem 'json'
gem 'nokogiri'
gem 'ropencc'   # Simple to Traditional Chinese
gem 'tidy_ffi'  # cleanup HTML

# Friendly ID
gem 'friendly_id'
gem 'babosa'

# Images
gem 'mini_magick'

# User management
gem 'devise'
gem 'devise-i18n'

# Utilities
gem 'addressable'
gem 'geared_pagination'
gem 'platform_agent'
gem 'ransack'
gem 'slim-rails'
gem 'spreadsheet_architect'
gem 'wicked_pdf'
