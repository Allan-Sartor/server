# ApiController: Classe base que todos os demais controllers herdarão por padrão.
# Esta classe é responsável por autenticar o usuário antes de cada ação.
class ApplicationController < ActionController::API
  before_action :set_default_format
  before_action :authenticate_api_user!
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
    devise_parameter_sanitizer.permit(:destroy, keys: [:password])
  end

  def show_not_found_errors(exception)
    render json: { error: "#{exception.message} with 'id'=#{params[:id]}" },
           status: :not_found
  end
end
