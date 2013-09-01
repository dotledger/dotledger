class AddToDateToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :to_date, :date
  end
end
