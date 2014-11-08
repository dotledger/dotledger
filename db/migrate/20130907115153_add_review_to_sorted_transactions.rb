class AddReviewToSortedTransactions < ActiveRecord::Migration
  def change
    add_column :sorted_transactions, :review, :boolean, null: false, default: false
  end
end
