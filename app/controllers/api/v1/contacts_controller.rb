# ContactsController: Classe responsável pelo gerenciamento das operações CRUD (Criar, Ler, Atualizar e Apagar) para os contatos dos usuários.
class Api::V1::ContactsController < ApplicationController
  before_action :set_contact, only: %i[show update destroy]

  # GET /contacts
  def index
    @contacts = current_user.contacts.all

    render json: @contacts
  end

  # GET /contacts/"ID do contato"
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = current_user.contacts.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/"ID do contato"
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/"ID do contato"
  def destroy
    @contact.destroy
  end

  private

  # Método para definir o contato a ser usado nas ações show, update e destroy.
  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  # Método para definir os parâmetros permitidos para criar/atualizar um contato.
  def contact_params
    params.require(:contact).permit(:name, :cpf, :phone, :address, :latitude, :longitude)
  end
end
