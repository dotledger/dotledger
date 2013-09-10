class Goal < ActiveRecord::Base
  GOAL_PERIODS = ['Month', 'Fortnight', 'Week']

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
      self.amount * 26 / 12
    when 'Week'
      self.amount * 52 / 12
    end
  end
end
