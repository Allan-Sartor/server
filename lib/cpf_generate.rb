# Módulo CpfGenerate
#
# Este módulo fornece métodos para gerar números de CPF válidos.
#
# Exemplos de uso:
#
#   CpfGenerate.generate_cpf
#   # => "12345678909" (um número de CPF gerado aleatoriamente)
#
# Métodos:
# - self.generate_cpf: Gera um número de CPF válido.
# - self.calculate_verifier_digit: Calcula o dígito verificador para um número de CPF.

module CpfGenerate
  # Gera um número de CPF válido.
  #
  # O método generate_cpf cria os primeiros nove dígitos do CPF de forma aleatória,
  # calcula os dois dígitos verificadores e retorna o número completo de CPF.
  #
  # @return [String] Um número de CPF válido.
  def self.generate_cpf
    digits = Array.new(9) { rand(0..9) }

    digits << calculate_verifier_digit(digits)
    digits << calculate_verifier_digit(digits)

    digits.join
  end

  # Calcula o dígito verificador para um número de CPF.
  #
  # O método calculate_verifier_digit utiliza os primeiros 9 ou 10 dígitos do CPF
  # para calcular o dígito verificador de acordo com a fórmula oficial do CPF.
  #
  # @param [Array<Integer>] digits Os primeiros 9 ou 10 dígitos do CPF.
  # @return [Integer] O dígito verificador calculado.
  def self.calculate_verifier_digit(digits)
    factor = digits.length + 1
    sum = digits.each_with_index.reduce(0) { |acc, (digit, index)| acc + (digit * (factor - index)) }
    remainder = sum % 11

    remainder < 2 ? 0 : 11 - remainder
  end
end
