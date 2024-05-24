# Módulo FormatHelper
# Fornece funções auxiliares para formatação de mensagens e serialização de um objeto em formato JSON
module FormatHelper
  protected

  def serializer_as_json(render)
    ActiveModelSerializers::SerializableResource.new(render).as_json
  end

  def render_message_i18n(message)
    I18n.t(message)
  end

  def render_error_message(message, status)
    render json: { error: render_message(message) }, status: status
  end
end
