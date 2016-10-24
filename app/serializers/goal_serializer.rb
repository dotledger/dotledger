class GoalSerializer < ActiveModel::Serializer
  attributes :id, :amount, :period, :type, :category_id, :category_name, :category_type,
             :month_amount
end
