# Classe: Api::V1::RegistrationsController
#
# Esta classe é responsável por gerenciar as ações de registro e destruição de contas dos usuários.
# Herda de `DeviseTokenAuth::RegistrationsController` e inclui o módulo `FormatHelper` para formatação de mensagens.
#
# Antes de qualquer ação, o usuário deve estar autenticado.

class Api::V1::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :authenticate_user!

  include FormatHelper

  # Método: destroy
  #
  # Este método é responsável por excluir a conta do usuário.
  # Primeiro, verifica se a senha fornecida é válida.
  # Se a senha for válida, a conta do usuário é excluída e uma mensagem de sucesso é renderizada.
  # Se a senha for inválida, uma mensagem de erro é renderizada com status 422.
  #
  # Params:
  # - password: A senha do usuário, necessária para confirmar a exclusão da conta.
  #
  # Returns:
  # - JSON com uma mensagem de sucesso ou erro, dependendo da validade da senha fornecida.
  def destroy
    # Verifica a senha do usuário
    if current_user.valid_password?(params[:password])
      # Exclui a conta do usuário
      current_user.destroy
      render json: { message: render_message_i18n('registration.account.destroy_success') }, status: :ok
    else
      render_error_message('registration.account.destroy_error', 422)
    end
  end
end
