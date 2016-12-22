class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :name, null: false
      t.string :query
      t.integer :category_id
      t.string :category_type
      t.datetime :date_from
      t.datetime :date_to
      t.string :period_from
      t.string :period_to
      t.integer :tag_ids, array: true
      t.integer :account_id
      t.string :review, null: false, default: ''

      t.timestamps null: false
    end

    add_index :saved_searches, :name, unique: true
  end
end
