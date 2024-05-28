require 'faker'
require 'cpf_generate'

puts 'Deletando dados do banco de testes...'

User.delete_all

puts 'Populando banco de testes...'

return if User.exists?

5.times do |i|
  user = User.create(
    email: "user#{i}@example.com",
    password: 'password',
    password_confirmation: 'password'
  )

  # Cria alguns contatos para cada usuário
  3.times do
    Contact.create(
      user_id: user.id,
      cpf: CpfGenerate.generate_cpf,
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.phone_number,
      address: 'R. ANGELO TOGNATO, 78 - Jardim PalomaColombo - PR, 83410-576'
    )
  end
end

puts 'Banco de dados de testes populado com sucesso!'
