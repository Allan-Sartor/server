# Configuração das rotas.
#
# As rotas definidas com o formato padrão JSON.
# As rotas utilizam o Devise Token Auth para autenticação do usuário e incluem rotas para gerenciar contatos.

require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # Monta as rotas do Devise Token Auth para o modelo User no caminho "/api/auth"
    mount_devise_token_auth_for 'User', at: 'auth'

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: false) do
      # Define as rotas padrão CRUD (Create, Read, Update, Delete) para o recurso contacts "/api/v1/contacts"
      resources :contacts

      # Rota personalizada para excluir a conta do usuário "/api/v1/delete_account"
      delete 'delete_account', to: 'registrations#destroy'
    end
  end
end
