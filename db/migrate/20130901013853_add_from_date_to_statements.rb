class AddFromDateToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :from_date, :date
  end
end
