class AddNotNullConstraintToCategoryIdOnSortedTransactions < ActiveRecord::Migration
  def change
    change_column :sorted_transactions, :category_id, :integer, null: false
  end
end
