class CategoryActivity
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :name, :type, :goal_amount, :goal_period, :goal_type, :goal, :received, :spent, :net
end
