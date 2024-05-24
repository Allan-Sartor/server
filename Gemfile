source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem 'rack-attack'
gem 'i18n'
gem "devise_token_auth", "~> 1.1"
gem 'kaminari'
gem 'active_model_serializers'

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails", "~> 6.4"
  gem "faker", "~> 3.3"
  gem "rspec-rails", "~> 6.1"
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', '~> 2.6.0', require: false
  gem 'solargraph'
end

group :development do
  gem 'bullet'
end

group :test do
  gem "database_cleaner-active_record", "~> 2.1"
  gem "simplecov", "~> 0.22.0"
  gem "shoulda-matchers", "~> 5.3"
  gem "simplecov_json_formatter", "~> 0.1.4"
end






