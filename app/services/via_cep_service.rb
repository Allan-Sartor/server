require 'httparty'

class ViaCepService
  include HTTParty
  base_uri 'https://viacep.com.br/ws'

  # Busca detalhes do endereço através do CEP na API Via Cep.
  #
  # Exemplo:
  #   ViaCepService.fetch_address('01001000')
  #
  # Retorna um hash com os detalhes do endereço ou um hash de mensagem de erro.
  def self.fetch_address(cep)
    response = get("/#{cep}/json/")
    if response.success?
      parse_address(response)
    else
      { error: I18n.t('via_cep_service.errors.unable_to_fetch_address', cep: cep) }
    end
  rescue StandardError => e
    { error: e.message }
  end

  # Analisa a resposta JSON da API Via Cep em um hash estruturado de endereço.
  def self.parse_address(response)
    {
      zip_code: response['cep'],
      street: response['logradouro'],
      complement: response['complemento'],
      neighborhood: response['bairro'],
      city: response['localidade'],
      state: response['uf']
    }
  end
end
