source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors" # Middleware para suporte a CORS.
gem 'rack-attack' # Middleware para proteção contra ataques de força bruta.
gem 'i18n' # Suporte a internacionalização.
gem 'devise' # Autenticação flexível para Rails.
gem "devise_token_auth", "~> 1.1" # Autenticação baseada em token para APIs.
gem 'kaminari' # Paginação para ActiveRecord, Mongoid e DataMapper.
gem 'active_model_serializers' # Serialização de objetos ActiveModel.
gem 'httparty' # Realiza requisições HTTP de forma simples.
gem 'dotenv-rails' # Carrega variáveis de ambiente de um arquivo .env.

group :development, :test do
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails", "~> 6.4" # Biblioteca para criação de dados de teste.
  gem "faker", "~> 3.3", require: false # Geração de dados fictícios.
end

group :development do
  gem 'bullet' # Detecta consultas N+1 e código ineficiente.
  gem 'letter_opener' # Visualiza e-mails no navegador durante o desenvolvimento.
  gem 'solargraph', require: false # Servidor de linguagem Ruby para IDEs.
  gem 'rubocop', "~> 1.53.0" # Ferramenta de análise estática de código.
  gem 'rubocop-performance', require: false # Extensão do RuboCop focada em performance.
  gem 'rubocop-rails', require: false # Extensão do RuboCop para projetos Rails.
  gem 'rubocop-rake', require: false # Extensão do RuboCop para Rake.
end

group :test do
  gem "simplecov", "~> 0.22.0" # Gera relatórios de cobertura de código.
  gem "simplecov_json_formatter", "~> 0.1.4" # Formata relatórios do SimpleCov em JSON.
  gem "shoulda-matchers", "~> 5.3" # Matchers para testes de modelos e controladores.
  gem 'rubocop-rspec', '~> 2.6.0', require: false # Extensão do RuboCop para projetos RSpec.
  gem "rspec-rails", "~> 6.1" # Framework de teste para Rails.
end
