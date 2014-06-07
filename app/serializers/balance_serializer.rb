class BalanceSerializer < ActiveModel::Serializer
  attributes :date, :balance, :account_id
end
