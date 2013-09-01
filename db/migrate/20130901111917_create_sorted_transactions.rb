class CreateSortedTransactions < ActiveRecord::Migration
  def change
    create_table :sorted_transactions do |t|
      t.string :name, :null => false
      t.belongs_to :transaction, :index => true, :null => false
      t.belongs_to :category, :index => true
      t.belongs_to :account, :index => true, :null => false

      t.timestamps
    end
  end
end
