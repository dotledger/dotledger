class AddNoteToSortedTransactions < ActiveRecord::Migration
  def change
    add_column :sorted_transactions, :note, :text
  end
end
