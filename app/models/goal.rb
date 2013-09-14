class Goal < ActiveRecord::Base
  GOAL_PERIODS = ['Month', 'Fortnight', 'Week']

  FORTNIGHT_MULTIPLIER = 13.0/6

  WEEK_MULTIPLIER = 13.0/3

  belongs_to :category

  validates :category, :presence => true

  validates :amount, :presence => true

  validates :period, :presence => true, :inclusion => GOAL_PERIODS

  delegate :name, :type, :to => :category, :prefix => true

  def month_amount
    case self.period
    when 'Month'
      self.amount
    when 'Fortnight'
      self.amount * FORTNIGHT_MULTIPLIER
    when 'Week'
      self.amount * WEEK_MULTIPLIER
    end
  end
end
