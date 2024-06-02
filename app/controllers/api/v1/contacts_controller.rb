# Controller: Api::V1::ContactsController
#
# Classe responsável pelo gerenciamento das operações CRUD (Criar, Ler, Atualizar e Apagar)
# para os contatos dos usuários.
#
# Este controller requer autenticação para acesso às suas ações.

class Api::V1::ContactsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_contact, only: %i[show update destroy]

  # Método: index
  #
  # Este método retorna uma lista paginada de contatos do usuário autenticado.
  #
  # Params:
  # - sort: (opcional) O campo pelo qual os contatos serão ordenados.
  # - dir: (opcional) A direção da ordenação (asc ou desc).
  # - page: (opcional) O número da página a ser retornada.
  # - per_page: (opcional) O número de contatos por página.
  #
  # Returns:
  # - JSON: Uma lista de contatos e meta informações de paginação.
  #
  # Exemplo de Requisição:
  #   GET /api/contacts
  #
  # Exemplo de Resposta de Sucesso:
  #   {
  #     "contacts": [
  #       {
  #         "id": 1,
  #         "name": "John Doe",
  #         "cpf": "123.456.789-00",
  #         "phone": "123456789",
  #         "address": "Rua Exemplo, 123",
  #         "latitude": "-23.550520",
  #         "longitude": "-46.633308"
  #       },
  #     ],
  #     "meta": {
  #       "current_page": 1,
  #       "total_pages": 5,
  #       "total_count": 50
  #     }
  #   }
  #
  # Códigos de Status:
  # - 200 OK: Lista de contatos retornada com sucesso.
  def index
    @contacts = filter_contacts
                .sorted(params[:sort], params[:dir])
                .page(current_page)
                .per(per_page)

    render json: { contacts: @contacts, meta: meta_attributes(@contacts) }, adapter: :json
  end

  # Método: show
  #
  # Este método retorna os detalhes de um contato específico.
  #
  # Params:
  # - id: O ID do contato que será retornado.
  #
  # Returns:
  # - JSON: Os detalhes do contato.
  #
  # Exemplo de Requisição:
  #   GET /api/contacts/1
  #
  # Retornar mesmo exemplo de sucesso do método INDEX (Sem meta)
  #
  # Códigos de Status:
  # - 200 OK: Contato retornado com sucesso.
  # - 404 Not Found: Contato não encontrado.
  def show
    render json: serializer_as_json(@contact)
  end

  # Método: create
  #
  # Este método cria um novo contato para o usuário autenticado.
  #
  # Params:
  # - name: O nome do contato.
  # - cpf: O CPF do contato.
  # - phone: O telefone do contato.
  # - address: O endereço do contato.
  # - latitude: A latitude do endereço do contato.
  # - longitude: A longitude do endereço do contato.
  #
  # Returns:
  # - JSON: Os detalhes do contato recém-criado.
  #
  # Exemplo de Requisição:
  #   POST /api/contacts
  #   Body:
  #   {
  #     "contact": {
  #       "name": "John Doe",
  #       "cpf": "123.456.789-00",
  #       "phone": "123456789",
  #       "address": "Rua Exemplo, 123",
  #     }
  #   }
  #
  # Exemplo de Resposta de Sucesso:
  #   {
  #     "success": "Contato criado com sucesso.",
  #     "contact": {
  #       "id": 1,
  #       "name": "John Doe",
  #       "cpf": "123.456.789-00",
  #       "phone": "123456789",
  #       "address": "Rua Exemplo, 123",
  #       "latitude": "-23.550520",
  #       "longitude": "-46.633308"
  #     }
  #   }
  #
  # Códigos de Status:
  # - 201 Created: Contato criado com sucesso.
  # - 422 Unprocessable Entity: Erro de validação dos parâmetros.
  def create
    @contact = current_api_user.contacts.new(contact_params)

    if @contact.save
      render json: {
        success: render_message_i18n('contacts.create.success'),
        contact: serializer_as_json(@contact)
      }, status: :created
    else
      render_error_message(@contact, 'contacts.create.error', :unprocessable_entity)
    end
  end

  # Método: update
  #
  # Este método atualiza um contato existente do usuário autenticado.
  #
  # Params:
  # - id: O ID do contato que será atualizado.
  # - name: O nome do contato.
  # - cpf: O CPF do contato.
  # - phone: O telefone do contato.
  # - address: O endereço do contato.
  #
  # Returns:
  # - JSON: Os detalhes do contato atualizado.
  #
  # Exemplo de Requisição:
  #   PATCH/PUT /api/contacts/1
  #
  #  Mesmo exemplo utilizado no método CREATE
  #  (Pórem pode ser atualizado passando somente um parametro se quiser ao invés de todos!)
  #
  # Exemplo de Resposta de Sucesso:
  #   {
  #     "success": "Contato atualizado com sucesso.",
  #     "contact": {
  #       "id": 1,
  #       "name": "John Doe",
  #       "cpf": "123.456.789-00",
  #       "phone": "123456789",
  #       "address": "Rua Exemplo, 123",
  #       "latitude": "-23.550520",
  #       "longitude": "-46.633308"
  #     }
  #   }
  #
  # Códigos de Status:
  # - 200 OK: Contato atualizado com sucesso.
  # - 422 Unprocessable Entity: Erro de validação dos parâmetros.
  def update
    if @contact.update(contact_params)
      render json: {
        success: render_message_i18n('contacts.update.success'),
        contact: serializer_as_json(@contact)
      }, status: :ok
    else
      render_error_message(@contact, 'contacts.update.error', :unprocessable_entity)
    end
  end

  # Método: destroy
  #
  # Este método exclui um contato existente do usuário autenticado.
  #
  # Params:
  # - id: O ID do contato que será excluído.
  #
  # Returns:
  # - JSON: Mensagem de sucesso.
  #
  # Exemplo de Requisição:
  #   DELETE /api/contacts/1
  #
  # Códigos de Status:
  # - 204 No Content: Contato excluído com sucesso.
  def destroy
    @contact.destroy
    head :no_content
  end

  private

  # Método: set_contact
  #
  # Este método define o contato a ser usado nas ações show, update e destroy.
  #
  # Params:
  # - id: O ID do contato que será definido.
  #
  # Returns:
  # - @contact: O contato encontrado.
  def set_contact
    @contact = current_api_user.contacts.find(params[:id])
  end

  # Método: contact_params
  #
  # Este método define os parâmetros permitidos para criar/atualizar um contato.
  #
  # Params:
  # - contact: Um objeto contendo os parâmetros do contato.
  #   - name: O nome do contato.
  #   - cpf: O CPF do contato.
  #   - phone: O telefone do contato.
  #   - address: O endereço do contato.
  #   - latitude: A latitude do endereço do contato.
  #   - longitude: A longitude do endereço do contato.
  #   - query: (opcional) Um termo de busca para filtrar contatos por CPF ou nome.
  #
  def contact_params
    params.require(:contact).permit(:name, :cpf, :phone, :address, :latitude, :longitude, :query)
  end

  # Método: filter_contacts
  #
  # Este método filtra os contatos com base no parâmetro "query" fornecido.
  #
  # Params:
  # - query: (opcional) Um termo de busca para filtrar contatos por CPF ou nome.
  #
  # Returns:
  # - JSON: Array contendo usuários encontrados ou [].
  #
  # Exemplo de Requisição:
  #   GET /api/contacts?name=John
  #
  # Exemplo de Resposta de Sucesso:
  #   {
  #     "contacts": [
  #       {
  #         "id": 1,
  #         "name": "John Doe",
  #         "cpf": "123.456.789-00",
  #         "phone": "123456789",
  #         "address": "Rua Exemplo, 123",
  #         "latitude": "-23.550520",
  #         "longitude": "-46.633308"
  #       },
  #     ]
  #   }
  #
  # Códigos de Status:
  # - 200 OK: Contatos filtrados retornados com sucesso.
  def filter_contacts
    if params[:query].present?
      current_api_user.contacts.filter_by_cpf_or_name(params[:query])
    else
      current_api_user.contacts
    end
  end
end
