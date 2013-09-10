class GoalSerializer < ActiveModel::Serializer
  attributes :id, :amount, :period, :category_id, :category_name, :category_type
end
