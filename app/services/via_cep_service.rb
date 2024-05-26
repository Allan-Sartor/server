require 'httparty'

class ViaCepService
  include FormatHelper
  include HTTParty
  base_uri 'https://viacep.com.br/ws'

  def self.fetch_address(cep)
    response = get("/#{cep}/json/")
    if    response.success?
        parse_address(response)
    else
      { error: I18n.t('via_cep_service.errors.unable_to_fetch_address', cep: cep) }
    end
  end

  private

  def self.parse_address(response)
    {
      zip_code: response['cep'],
      street: response['logradouro'],
      complement: response['complemento'],
      neighborhood: response['bairro'],
      city: response['localidade'],
      state: response['uf'],
    }
  end
end
