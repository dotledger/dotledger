class AddBalanceToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :balance, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
