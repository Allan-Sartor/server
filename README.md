<h2>
  📃 Sobre a API
</h2>

O projeto envolve a criação de uma API para gerenciamento de contatos com funcionalidades e integrações específicas, utilizando autenticação via devise_token_auth.

<h2> Funcionalidades <h2>

<h3> Registro e Autenticação do Usuário <h3>
- Registro e login de usuário.
- Recuperação de senha via e-mail.
- Logout de usuário.
- Autenticação para gerenciamento de contatos e configurações da conta.

<h3> Gerenciamento de Conta <h3>
- Exclusão de conta com verificação de senha.

<h3> Gerenciamento de Contatos <h3>
- Adicionar, editar e excluir contatos.
- Campos de contato: nome, CPF, telefone, endereço completo (incluindo CEP) e coordenadas geográficas (latitude e longitude).
- Preenchimento automático de endereço com base em UF, cidade e trecho do endereço utilizando Via Cep.
- Listagem de contatos com filtro de busca por nome ou CPF.

<i>Contacts API</i>

<h2>🔧 Ferramentas utilizadas</h2>
Para o desenvolvimento do projeto, foram utilizados as principais ferramentas:
<ul>
  <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  <li><a href="https://github.com/lynndylanhurley/devise_token_auth">Devise Token Auth</a></li>
  <li><a href="https://rubygems.org/gems/kaminari/versions/0.17.0?locale=pt-BR">Kaminari</a></li>
  <li><a href="https://rubygems.org/gems/active_model_serializers/versions/0.10.2?locale=pt-BR">Active Model Serializers</a></li>
  <li><a href="https://rubygems.org/gems/rack-attack/versions/5.0.1">Rack Attack</a></li>
  <li><a href="https://github.com/rspec/rspec-rails">RSpec-rails</a></li>
  <li><a href="https://rubygems.org/gems/bullet/versions/6.1.0?">RSpec-rails</a></li>
  <li><a href="https://www.postman.com/">Insomnia</a></li>locale=pt-BR
</ul>

<h2>⚙ Rodando a aplicação</h2>
<ul>
  <li>É <b>necessário</b> possuir o <a href="https://www.ruby-lang.org/pt/documentation/installation/">Ruby</a>,</li>
  <li><a href="https://www.postgresql.org/">PostgreSQL</a>.</li>
</ul>

1. Clone o repositório em sua máquina utilizando:

```sh
  $ git clone https://github.com/Allan-Sartor/server-v1.git
```

2. Configuração e Execução

```bash
git clone https://github.com/Allan-Sartor/server.git
cd server

# Instalação das dependências
bundle install

# Criação do banco de dados e tabelas
rails db:create
rails db:migrate
rails db:migrate RAILS_ENV=test

# Rode do projeto
rails s -p 3001
```

3. Se tudo estiver certo, à API irá iniciar no endereço http://localhost:3001/

Para configurar [CORS](https://github.com/cyu/rack-cors) `origins`, altere o arquivo
`config/initializers/cors.rb`.

<hr>

<h2>🧪 Testes</h2>

Para rodar os testes:

```bash
bundle exec rspec
```

<hr>

<h2>🔍 Insomnia para testes na API</h2>

Se você deseja importar as requisições para o [Insomnia](https://insomnia.rest/download), utilize o arquivo `Insomnia.json` na raiz deste projeto.

Será necessário instalar o plugin [insomnia-plugin-dotenv](https://insomnia.rest/plugins/insomnia-plugin-dotenv).

1. Crie um arquivo de variáveis de ambiente na raiz do projeto para adicionar dados sensíveis:

```bash
touch .env.development
```

2. Adicione o seguinte conteúdo no arquivo:

```bash
password=your-password
access-token=your-access-token
client=your-client
```

3. No Insomnia, vá para `Manage Environments` e configure o valor `envFilePath` para o caminho do arquivo `.env.development`:

```json
{
  // ... seu código acima
  "envFilePath": "/path/to/file/your_repo/.env.development"
}
```

Qualquer arquivo `.env.*` está sendo ignorado pelo GIT deste projeto.

<hr>

<h4 align="center">
    Created by <a href="https://www.linkedin.com/in/allan-sartor-aa6844131/" target="_blank">Allan Sartor</a>
</h4>
