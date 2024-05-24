# Configuração das rotas.
#
# As rotas definidas com o formato padrão JSON.
# As rotas utilizam o Devise Token Auth para autenticação do usuário e incluem rotas para gerenciar contatos.

require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # Monta as rotas do Devise Token Auth para o modelo User no caminho /api/auth
    mount_devise_token_auth_for 'User', at: 'auth'

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: false) do
      # Monta as rotas do Devise Token Auth para o modelo User no caminho /api/delete_account
      # Utiliza o controller customizado para registros localizado em api/v1/registrations
      mount_devise_token_auth_for 'User', at: 'delete_account', controllers: {
        registrations: 'api/v1/registrations'
      }

      # Define as rotas padrão CRUD (Create, Read, Update, Delete) para o recurso contacts
      resources :contacts
    end
  end
end
