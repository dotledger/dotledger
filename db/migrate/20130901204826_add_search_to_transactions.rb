class AddSearchToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :search, :string, :null => false
  end
end
