class CategoryActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :goal_amount, :goal_period, :goal, :received, :spent, :net
end