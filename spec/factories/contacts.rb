FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    cpf { Faker::Number.number(digits: 11) }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    address { 'R. ANGELO TOGNATO, 78 - Jardim PalomaColombo - PR, 83410-576' }
    user

    factory :invalid_contact do
      name { nil }
      cpf { nil }
      phone { nil }
      address { 'R. ANGELO TOGNATO, 78 - Jardim PalomaColombo - PR, 83410-576' }
      user
    end
  end
end
