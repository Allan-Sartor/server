class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_api_user!

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