class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :type, :updated_at, :balance,
    :unsorted_transaction_count, :sorted_transaction_count,
    :review_transaction_count, :account_group_id, :account_group_name,
    :archived

  def unsorted_transaction_count
    object.transactions.unsorted.count
  end

  def sorted_transaction_count
    object.transactions.not_for_review.sorted.count
  end

  def review_transaction_count
    object.transactions.for_review.count
  end
end
