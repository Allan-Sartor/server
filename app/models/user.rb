# Classe da tabela de usuários gerada via devise
class User < ApplicationRecord
  has_many :contacts, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
end
