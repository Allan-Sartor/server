require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    # cofiguração session store
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.load_defaults 7.0

    # Configura a aplicação como API only
    config.api_only = true

    # Desativa a exigência da chave mestra
    config.require_master_key = false

    # Adiciona arquivos de tradução personalizados
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]

    # Define os locais disponíveis
    I18n.available_locales = [:"en-US", :"pt-BR"]

    # Define o locale padrão
    I18n.default_locale = :"pt-BR"

    # Devise
    config.action_mailer.default_url_options = { host: 'localhost:3001' }
  end
end
