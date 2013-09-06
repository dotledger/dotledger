class SortingRuleSerializer < ActiveModel::Serializer
  attributes :id, :contains, :name, :category_id, :category_name
end
