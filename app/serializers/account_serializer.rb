class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :type, :updated_at, :balance
end
