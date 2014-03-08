class AddTagIdsToSortedTransactions < ActiveRecord::Migration
  def change
    add_column :sorted_transactions, :tag_ids, :integer, array: true
  end
end
