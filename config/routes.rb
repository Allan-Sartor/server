# Configuração das rotas.
#
# As rotas definidas com o formato padrão JSON.
# As rotas utilizam o Devise Token Auth para autenticação do usuário e incluem rotas para gerenciar contatos.

require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # Monta as rotas do Devise Token Auth para o modelo User no caminho "/api/auth"
    mount_devise_token_auth_for 'User', at: 'auth'

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # Define as rotas padrão CRUD (Create, Read, Update, Delete) para o recurso contacts "/api/contacts"
      resources :contacts

      get 'addresses/:cep', to: 'addresses#search'
    end
  end
end
