class CategoryTypeActivitySerializer < ActiveModel::Serializer
  attributes :type, :received, :spent, :net
end