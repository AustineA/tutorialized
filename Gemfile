source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 7.0.0"
gem "httparty"
gem "jb"
gem "maxminddb"
gem "countries", require: "countries/global"
gem "money", "~> 6.9"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "redis", "~> 4.0"
gem "sidekiq"
gem 'active_storage_validations'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
gem "kredis"
gem 'jwt'
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "rack-cors"
gem "aws-sdk-s3", require: false
gem "fog-aws"
gem "will_paginate"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "solargraph"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

