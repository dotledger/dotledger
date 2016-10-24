class AddTypeToGoals < ActiveRecord::Migration
  def up
    add_column :goals, :type, :string, default: 'Spend', null: false
    Goal.where('amount < 0').update_all("amount = abs(amount), type = 'Receive'")
  end

  def down
    Goal.where(type: 'Receive').update_all("amount = -amount")
    remove_column :goals, :type
  end
end
