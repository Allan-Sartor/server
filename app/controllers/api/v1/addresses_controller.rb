class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_api_user!

  # Controller: Api::V1::AddressesController
  #
  # O controller fornece buscas de endereços
  # através do serviço ViaCep utilizando o CEP informado.
  #
  # Este controller requer autenticação para acesso as suas ações.

  # Método: search
  #
  # Este método busca um endereço utilizando o CEP fornecido.
  #
  # Params:
  # - cep: O CEP que será utilizado para buscar o endereço.
  #
  # Returns:
  # - JSON: Os detalhes do endereço correspondentes ao CEP fornecido.
  #
  # Exemplo de Requisição:
  #   GET /api/v1/addresses/search?cep=01001000
  #
  # Exemplo de Resposta de Sucesso:
  #   {
  #     "cep": "01001-000",
  #     "logradouro": "Praça da Sé",
  #     "complemento": "lado ímpar",
  #     "bairro": "Sé",
  #     "localidade": "São Paulo",
  #     "uf": "SP",
  #   }
  #
  # Códigos de Status:
  # - 200 OK: Endereço encontrado com sucesso.
  # - 400 Bad Request: CEP ausente ou inválido.
  def search
    cep = params[:cep]

    if cep.present?
      address = ViaCepService.fetch_address(cep)
      render json: address
    else
      render json: { error: I18n.t('addresses_controller.errors.missing_cep', cep: cep) }, status: :bad_request
    end
  end
end
