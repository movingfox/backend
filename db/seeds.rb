# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   Rake::Task['db:fixtures:load'].invoke("MODEL='xxx,yyy'")

Administrator.create(email: Rails.application.credentials.admin[:email].to_s,
    password: Rails.application.credentials.admin[:password].to_s,
    first_name: 'Name', last_name: 'Surname')
