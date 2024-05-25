# ContactsController: Classe responsável pelo gerenciamento das operações CRUD (Criar, Ler, Atualizar e Apagar) para os contatos dos usuários.
class Api::V1::ContactsController < ApplicationController
  include Paginable

  before_action :authenticate_api_user!
  before_action :set_contact, only: %i[show update destroy]

  # GET /contacts
  def index
    @contacts = current_api_user.contacts.includes(:user)
                                .sorted(params[:sort], params[:dir])
                                .page(current_page)
                                .per(per_page)

    render json: { contacts: @contacts, meta: meta_attributes(@contacts) }, adapter: :json
  end

  # GET /contacts/"ID do contato"
  def show
    render json: serializer_as_json(@contact)
  end

  # POST /contacts
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

  # PATCH/PUT /contacts/"ID do contato"
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

  # DELETE /contacts/"ID do contato"
  def destroy
    @contact.destroy
  end

  private

  # Método para definir o contato a ser usado nas ações show, update e destroy.
  def set_contact
    @contact = current_api_user.contacts.find(params[:id])
  end

  # Método para definir os parâmetros permitidos para criar/atualizar um contato.
  def contact_params
    params.require(:contact).permit(:name, :cpf, :phone, :address, :latitude, :longitude)
  end
end
