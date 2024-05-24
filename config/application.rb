require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
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
  end
end
