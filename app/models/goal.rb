class Goal < ActiveRecord::Base
  GOAL_PERIODS = ['Month', 'Fortnight', 'Week']

  belongs_to :category

  validates :category, :presence => true

  validates :amount, :presence => true

  validates :period, :presence => true, :inclusion => GOAL_PERIODS

  delegate :name, :type, :to => :category, :prefix => true
end
