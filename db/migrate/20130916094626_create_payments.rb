class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name, :null => false
      t.belongs_to :category, :index => true, :null => false
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.string :type, :null => false, :default => 'Spend'
      t.text :schedule, :null => false

      t.timestamps
    end

    add_index :payments, :name, :unique => true
  end
end
