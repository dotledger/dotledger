class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :category_id, :type, :schedule, :upcoming

  def upcoming
    schedule.next_occurrences(5)
  end
end
