class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.string :fit_id, :null => false
      t.string :memo
      t.string :name
      t.string :payee
      t.datetime :posted_at, :null => false
      t.string :ref_number
      t.string :type
      t.references :account, :index => true, :null => false

      t.timestamps
    end
  end
end
