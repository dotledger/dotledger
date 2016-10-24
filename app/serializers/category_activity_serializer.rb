class CategoryActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :goal_amount, :goal_period, :goal_type, :goal, :received, :spent, :net
end