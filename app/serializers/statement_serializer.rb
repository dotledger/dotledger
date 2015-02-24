class StatementSerializer < ActiveModel::Serializer
  attributes :id, :account_id, :balance, :from_date, :to_date, :created_at, :transaction_count

  def transaction_count
    object.transactions.count
  end
end
