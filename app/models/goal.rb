class Goal < ActiveRecord::Base
  self.inheritance_column = nil

  GOAL_PERIODS = %w(Month Fortnight Week)

  GOAL_TYPES = %w(Spend Receive)

  FORTNIGHT_MULTIPLIER = 13.0 / 6

  WEEK_MULTIPLIER = 13.0 / 3

  belongs_to :category

  validates :category, presence: true

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  validates :type, presence: true, inclusion: GOAL_TYPES

  validates :period, presence: true, inclusion: GOAL_PERIODS

  delegate :name, :type, to: :category, prefix: true

  def month_amount
    case period
    when 'Month'
      amount
    when 'Fortnight'
      amount * FORTNIGHT_MULTIPLIER
    when 'Week'
      amount * WEEK_MULTIPLIER
    end
  end
end
