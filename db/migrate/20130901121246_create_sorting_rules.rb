class CreateSortingRules < ActiveRecord::Migration
  def change
    create_table :sorting_rules do |t|
      t.string :contains, :null => false
      t.string :name, :default => nil 
      t.belongs_to :category, :index => true, :null => false

      t.timestamps
    end

    add_index :sorting_rules, :contains, :unique => true
  end
end
