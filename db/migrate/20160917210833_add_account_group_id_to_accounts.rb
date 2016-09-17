class AddAccountGroupIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :account_group_id, :integer
  end
end
