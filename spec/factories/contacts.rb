Faker::Config.locale = 'pt-BR'
FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    cpf { Faker::Number.number(digits: 11) }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    address { 'R. ANGELO TOGNATO, 78 - Jardim PalomaColombo - PR, 83410-576' }
  end
end
