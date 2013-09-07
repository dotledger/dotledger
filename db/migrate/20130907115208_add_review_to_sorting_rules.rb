class AddReviewToSortingRules < ActiveRecord::Migration
  def change
    add_column :sorting_rules, :review, :boolean, :null => false, :default => false
  end
end
