require 'httparty'

class GoogleMapsService
  include HTTParty
  include FormatHelper
  
  base_uri 'https://maps.googleapis.com/maps/api'
  
  def self.fetch_geolocation(address)
    api_key = ENV['GOOGLE_MAPS_API_KEY']

    raise I18n.t('google_maps_service.errors.no_assign_api_key') unless api_key.present?

    response = get("/geocode/json", query: { address: address, key: api_key })

    if response.success?
      parse_geolocation(response, address)
    else
      { error: I18n.t('google_maps_service.errors.unable_to_fetch_geolocation', address: address) }
    end
  end

  private

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
