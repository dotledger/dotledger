class CreateAccountGroups < ActiveRecord::Migration
  def change
    create_table :account_groups do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :account_groups, :name, unique: true
  end
end
