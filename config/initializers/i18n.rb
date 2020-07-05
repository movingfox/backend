# frozen_string_literal: true

# Where the I18n library should search for translation files
# I18n.load_path += Dir[Rails.root.join('lib/locale/*.{rb,yml}')]

# Permitted locales available for the application
I18n.available_locales = [:en, 'zh-TW']

# Set default locale to something other than :en
I18n.default_locale = 'zh-TW'

# Add all files in config/locales directory
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

