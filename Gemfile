source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem 'i18n'
gem 'devise'
gem 'kaminari'

group :development do
  gem 'bullet'
end

group :test do
  gem "database_cleaner-active_record", "~> 2.1"
  gem "simplecov", "~> 0.22.0"
  gem "shoulda-matchers", "~> 5.3"
  gem "simplecov_json_formatter", "~> 0.1.4"
end

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.3"
  gem "rspec-rails", "~> 6.1"
end




