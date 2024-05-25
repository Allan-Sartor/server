# Serializador tabela de users
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  has_many :contacts
end
