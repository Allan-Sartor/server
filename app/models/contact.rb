class Contact < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: { scope: :user_id }
  validates :phone, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  validate :valid_cpf

  private

  def valid_cpf
    errors.add(:cpf, 'é inválido') unless cpf.present? && cpf_valid?(cpf)
  end

  def cpf_valid?(cpf)
    cpf = cpf.gsub(/[^\d]/, '')

    return false if cpf.length != 11
    return false if cpf.chars.uniq.length == 1

    # Cálculo do primeiro dígito verificador
    first_digit = calculate_digit(cpf[0..8])

    # Cálculo do segundo dígito verificador
    second_digit = calculate_digit(cpf[0..9])

    first_digit == cpf[9].to_i && second_digit == cpf[10].to_i
  end

  def calculate_digit(digits)
    factor = digits.length + 1
    sum = 0

    digits.chars.each_with_index do |digit, index|
      sum += digit.to_i * (factor - index)
    end

    result = 11 - (sum % 11)
    result > 9 ? 0 : result
  end
end
