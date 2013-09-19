class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :category_id, :type, :schedule, :upcoming

  def upcoming
    schedule.occurrences_between(Date.today, Date.today + 30.days)
  end
end
