FactoryBot.define do
  factory :user do
    email { 'allansartor@outlook.com' }
    provider { 'email' }
    uid { 'allansartor@outlook.com' }
    allow_password_change { false }
    name { nil }
    nickname { nil }
    image { nil }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
