class AddArchivedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :archived, :bool, default: false, null: false
  end
end
