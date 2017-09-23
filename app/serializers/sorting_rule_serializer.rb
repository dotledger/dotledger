class SortingRuleSerializer < ActiveModel::Serializer
  attributes :id, :contains, :name, :category_id, :category_name, :review,
    :tag_list, :tag_ids
end
