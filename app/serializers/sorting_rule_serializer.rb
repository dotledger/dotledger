class SortingRuleSerializer < ActiveModel::Serializer
  attributes :id, :contains, :name, :category_id, :category_name, :review,
    :tag_list, :tag_ids

  def tag_list
    object.tags.map(&:name).join(', ')
  end
end
