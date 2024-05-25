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
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.sort_by
    ['cpf', 'name']
  end

  private_class_method :sort_by
end
