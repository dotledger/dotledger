class CategoryActivity
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :name, :type, :goal_amount, :goal_period, :goal, :received, :spent, :net

  def active_model_serializer
    CategoryActivitySerializer
  end
end
