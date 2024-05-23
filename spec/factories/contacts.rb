Faker::Config.locale = 'pt-BR'
FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    cpf { Faker::Number.number(digits: 11) }
    phone { Faker::PhoneNumber.cell_phone_with_country_code }
    address { Faker::Address.street_address }
    complement { Faker::Address.secondary_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
