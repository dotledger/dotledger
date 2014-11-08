class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.belongs_to :category, index: true, null: false
      t.decimal :amount, precision: 10, scale: 2, default: 0.0, null: false
      t.string :period, null: false, default: 'Month'

      t.timestamps
    end
  end
end
