class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :category_id, :category_name, :category_type,
    :type, :schedule, :upcoming, :repeat, :repeat_interval, :repeat_period, :date

  def repeat
    !object.schedule.recurrence_rules.empty?
  end

  def repeat_interval
    # FIXME: this is a bit yuck
    first_rule.instance_variable_get(:@interval)
  end

  def repeat_period
    case first_rule.class.to_s
    when 'IceCube::DailyRule'
      'Day'
    when 'IceCube::WeeklyRule'
      'Week'
    when 'IceCube::MonthlyRule'
      'Month'
    end
  end

  def date
    object.schedule.start_time.strftime('%Y-%m-%d')
  end

  def upcoming
    object.schedule.occurrences_between(Date.today, Date.today + 30.days)
  end

  private

  def first_rule
    object.schedule.recurrence_rules.first
  end
end
