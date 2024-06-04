# Classe Contact representa um contato que pertence a um usuário.
class Contact < ApplicationRecord
  # Inclui o módulo Sortable para suporte à ordenação.
  include Sortable

  # Inclui o validador de CPF personalizado.
  include CpfValidator

  # Associações
  belongs_to :user

  # Validações
  validates :cpf, presence: true, uniqueness: { scope: :user_id }, on: :create
  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  # Antes da validação, executa a geocodificação do endereço se houver mudanças no mesmo.
  before_validation :geocode_address, if: -> { address.present? && will_save_change_to_address? }

  # Define o escopo de pesquisa para busca por CPF ou nome.
  def self.filter_by_cpf_or_name(query)
    where('cpf LIKE ? OR name LIKE ?', "%#{query}%", "%#{query}%")
  end

  # Define os atributos pelos quais os resultados podem ser ordenados.
  def self.sort_by
    ['cpf', 'name']
  end

  private

  # Método privado para geocodificar o endereço usando um serviço externo, como Google Maps.
  def geocode_address
    result = GoogleMapsService.fetch_geolocation(address)
    if result[:error]
      errors.add(:address, result[:error])
    else
      self.latitude = result[:latitude]
      self.longitude = result[:longitude]
    end
  end
end
