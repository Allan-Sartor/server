# Módulo: CpfValidator
#
# O módulo `CpfValidator` fornece um método para validar números de CPF.
# Ele inclui uma validação que verifica se um CPF é válido de acordo com o algoritmo de cálculo de dígitos verificadores.
module CpfValidator
  extend ActiveSupport::Concern

  included do
    validate :valid_cpf
  end

  private

  # Método para validar o CPF
  def valid_cpf
    errors.add(:cpf, 'é inválido!') unless cpf.present? && cpf_valid?(cpf)
  end

  # Método para verificar se um CPF é válido
  def cpf_valid?(cpf)
    # Remove caracteres não numéricos do CPF
    cpf = cpf.gsub(/[^\d]/, '')

    # Verifica se o CPF tem 11 dígitos e não possui todos os dígitos iguais
    return false if cpf.length != 11
    return false if cpf.chars.uniq.length == 1

    # Calcula o primeiro dígito verificador
    first_digit = calculate_digit(cpf[0..8])

    # Calcula o segundo dígito verificador
    second_digit = calculate_digit(cpf[0..9])

    # Verifica se os dígitos verificadores calculados correspondem aos dígitos do CPF
    first_digit == cpf[9].to_i && second_digit == cpf[10].to_i
  end

  # Método para calcular um dígito verificador do CPF
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
