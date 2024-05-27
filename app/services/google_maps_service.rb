require 'httparty'

# Módulo: GoogleMapsService
#
# O serviço `GoogleMapsService` fornece funções para buscar a geolocalização de um endereço
# utilizando a API do Google Maps.
class GoogleMapsService
  include HTTParty

  base_uri 'https://maps.googleapis.com/maps/api'

  # Método: self.fetch_geolocation
  #
  # Este método busca a geolocalização (latitude e longitude) de um endereço fornecido.
  #
  # Params:
  # - address: O endereço que será utilizado para buscar a geolocalização.
  #
  # Returns:
  # - JSON: A geolocalização (latitude e longitude) do endereço fornecido.
  #
  # Exemplo de Resposta de Sucesso:
  #   {
  #     "latitude": -23.550520,
  #     "longitude": -46.633308
  #   }
  #
  # Exemplo de Resposta de Erro:
  #   {
  #     "error": "Não foi possível obter a geolocalização para o endereço: Praça da Sé, São Paulo, SP"
  #   }
  #
  def self.fetch_geolocation(address)
    api_key = ENV.fetch('GOOGLE_MAPS_API_KEY', nil)

    raise I18n.t('google_maps_service.errors.no_assign_api_key') unless api_key.present?

    response = get('/geocode/json', query: { address: address, key: api_key })

    if response.success?
      parse_geolocation(response, address)
    else
      { error: I18n.t('google_maps_service.errors.unable_to_fetch_geolocation', address: address) }
    end
  end

  # Método: self.parse_geolocation
  #
  # Este método analisa a resposta da API do Google Maps para extrair a geolocalização.
  #
  # Params:
  # - response: A resposta da API do Google Maps.
  # - address: O endereço que foi utilizado para buscar a geolocalização.
  #
  # Returns:
  # - JSON: A geolocalização (latitude e longitude) se encontrada, caso contrário, um erro.
  def self.parse_geolocation(response, address)
    result = response['results'].first
    if result
      {
        latitude: result['geometry']['location']['lat'],
        longitude: result['geometry']['location']['lng']
      }
    else
      { error: I18n.t('google_maps_service.errors.no_results_found', address: address) }
    end
  end
end
