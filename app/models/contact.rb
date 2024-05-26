# Classe Contact representa um contato que pertence a um usuário.
# Inclui validações para garantir a presença e unicidade de atributos como CPF, nome, telefone, endereço, latitude e longitude.
# Também realiza a validação do CPF com base em cálculos de dígitos verificadores.
class Contact < ApplicationRecord
  include Sortable

  belongs_to :user

  include CpfValidator

  validates :cpf, presence: true, uniqueness: { scope: :user_id }, on: :create
  validates :name, presence: true
  validates :phone, presence: true
  validates :address, presence: true

  before_validation :geocode_address, if: -> { address.present? && will_save_change_to_address? }

  def self.filter_by_cpf_or_name(query)
    where('cpf LIKE ? OR name LIKE ?', "%#{query}%", "%#{query}%")
  end

  def self.sort_by
    ['cpf', 'name']
  end

  private_class_method :sort_by

  private

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
