# Serializador tabela de contatos
class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :phone, :address, :latitude, :longitude

  belongs_to :user
end
