class Category < ActiveRecord::Base
  self.inheritance_column = nil

  has_many :sorted_transactions

  has_many :sorting_rules

  has_many :payments

  has_one :goal

  CATEGORY_TYPES = %w(Flexible Essential Income Transfer)

  validates :name, presence: true, uniqueness: true

  validates :type, presence: true, inclusion: { in: CATEGORY_TYPES }

  after_create :create_default_goal

  private

  def create_default_goal
    create_goal(amount: 0.0, period: 'Month') if goal.nil?
  end
end
