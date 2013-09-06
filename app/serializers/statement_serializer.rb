class StatementSerializer < ActiveModel::Serializer
  attributes :id, :account_id, :balance, :from_date, :to_date
end
