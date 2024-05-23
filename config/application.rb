require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    config.load_defaults 7.0

    config.api_only = true
    config.require_master_key = false

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]

    I18n.available_locales = [:"en-US", :"pt-BR"]
    I18n.default_locale = :"pt-BR"
  end
end
