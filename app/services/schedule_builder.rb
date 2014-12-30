require 'ice_cube'

class ScheduleBuilder
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def build
    set_date! if valid_date?
    set_recurrence_rules! if repeats?

    schedule
  end

  private

  def repeats?
    params[:repeat].to_s =~ /true/i
  end

  def valid_date?
    Date.parse(params[:date].to_s)
    true
  rescue
    false
  end

  def set_date!
    schedule.start_time = Date.parse(params[:date].to_s)
  end

  def set_recurrence_rules!
    rule =
      case params[:repeat_period].to_s
      when 'Day'
        IceCube::DailyRule.new(repeat_interval)
      when 'Week'
        IceCube::WeeklyRule.new(repeat_interval)
      when 'Month'
        IceCube::MonthlyRule.new(repeat_interval)
      end

    schedule.add_recurrence_rule(rule)
  end

  def repeat_interval
    params[:repeat_interval].to_s.to_i
  end

  def schedule
    @schedule ||= IceCube::Schedule.new
  end
end
