class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :type, :updated_at, :balance,
    :unsorted_transaction_count

  def unsorted_transaction_count
    object.transactions.unsorted.count 
  end
end
