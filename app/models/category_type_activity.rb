class CategoryTypeActivity
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :type, :received, :spent, :net

  def active_model_serializer
    CategoryTypeActivitySerializer
  end
end
