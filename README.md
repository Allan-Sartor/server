<h2>
  📃 Sobre a API
</h2>

O projeto envolve a criação de uma API para gerenciamento de contatos e integrações com Via CEP e GoogleMaps, para facilitar a criação de novos contatos com endereço e geolocalização.

<hr>

<h3> 💡 Funcionalidades </h3>

<h4> Registro e Autenticação do Usuário </h4>
- Registro e login de usuário.<br>
- Logout de usuário.<br>
- Autenticação via token para genenciamento de contatos e configurações da conta.
- Recuperação de senha via e-mail.<br>

<h4> Gerenciamento de Conta </h4>
- Exclusão de conta com verificação de senha.

<h4> Gerenciamento de Contatos </h4>
- Adicionar, editar e excluir contatos.<br>
- Preenchimento automático de endereço com base em UF, cidade e trecho do endereço utilizando Via Cep.<br>
- Listagem dos contatos com filtro de busca por nome ou CPF.

<hr>

<h2>🔧 Ferramentas utilizadas</h2>
Para o desenvolvimento do projeto, foram utilizados as principais ferramentas:
<br><br>
<ul>
  <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  <li><a href="https://github.com/lynndylanhurley/devise_token_auth">Devise Token Auth</a></li>
  <li><a href="https://github.com/rspec/rspec-rails">RSpec-rails</a></li>
  <li><a href="https://www.postman.com/">Insomnia</a></li>
</ul>

<hr>

<h2>⚙ Rodando a aplicação</h2>
<ul>
  É <b>necessário</b> ter instalado:
<br><br>
  <li><a href="https://www.ruby-lang.org/pt/documentation/installation/">Ruby</a> v.3.0.0 ou superior</li> 
  <li><a href="https://www.postgresql.org/">PostgreSQL</a>.</li>
  <li><a href="https://guides.rubyonrails.org/v5.0/getting_started.html">Framework Rails</a>.</li>
</ul>

<h4> Após instalar o necessário: </h4>

1. Clone o repositório em sua máquina utilizando:

```sh
  $ git clone https://github.com/Allan-Sartor/server-v1.git
```

2. Configuração e Execução

```bash
# Acessar pasta do projeto
cd server

# Acessar pasta
cd bin

# Agora rode no terminal
sudo chmod +x setup_server.sh

# Execute o script para que seja montado o servidor!
./setup_server.sh

```

3. Se tudo estiver certo, à API irá iniciar no endereço http://localhost:3001/

OBS:

- Para configurar [CORS](https://github.com/cyu/rack-cors)`origins`, altere o arquivo
  `config/initializers/cors.rb`.

<hr>

<h2>🧪 Testes</h2>

Para rodar os testes:

```bash
rspec
```

Obs: Os testes são executados no `./setup_server.sh` antes de iniciar o servidor!

<hr>

<h2>🔍 Insomnia para testes na API</h2>

Se você deseja importar as requisições para o [Insomnia](https://insomnia.rest/download), utilize o arquivo `Insomnia-doc.json` na raiz deste projeto.

Será necessário instalar o plugin [insomnia-plugin-dotenv](https://insomnia.rest/plugins/insomnia-plugin-dotenv).

1. Crie um arquivo de variáveis de ambiente na raiz do projeto para adicionar dados sensíveis:

```bash
touch .env.development
```

2. Adicione o seguinte conteúdo no arquivo:

```bash
password=seu-password
access-token=seu-access-token
client=seu-client
GOOGLE_MAPS_API_KEY=seu-google-maps-api-key
POSTGRES_HOST_DEV=seu-host-db
POSTGRES_USER_DEV=seu-user-db
POSTGRES_PASSWORD_DEV=seu-password-db
```

3. No Insomnia, vá para `Manage Environments` e configure o valor `envFilePath` para o caminho do arquivo `.env.development`:

```json
{
  "envFilePath": "/path/to/file/your_repo/.env.development"
}
```

Qualquer arquivo `.env.*` está sendo ignorado pelo GIT deste projeto.

Obs: É de extrema importância que a key para o google maps seja definida para que ocorra o funcionamento correto da API e sua comunicação com a Google Maps.

<hr>
<h4 align="center">
    Created by <a href="https://www.linkedin.com/in/allan-sartor-aa6844131/" target="_blank">Allan Sartor</a>
</h4>
