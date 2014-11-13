class SortedTransactionSerializer < ActiveModel::Serializer
  attributes :id, :name, :transaction_id, :category_id, :account_id,
             :category_name, :review, :tag_list, :tag_ids

  def tag_list
    object.tags.map(&:name).join(', ')
  end
end
