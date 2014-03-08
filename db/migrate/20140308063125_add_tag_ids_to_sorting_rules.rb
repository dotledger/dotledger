class AddTagIdsToSortingRules < ActiveRecord::Migration
  def change
    add_column :sorting_rules, :tag_ids, :integer, array: true
  end
end
