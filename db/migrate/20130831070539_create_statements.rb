class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.belongs_to :account, index: true, null: false
      t.decimal :balance, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
