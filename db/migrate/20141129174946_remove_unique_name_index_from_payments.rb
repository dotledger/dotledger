class RemoveUniqueNameIndexFromPayments < ActiveRecord::Migration
  def change
    remove_index :payments, column: :name, unique: true
  end
end
