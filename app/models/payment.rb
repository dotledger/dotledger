require 'schedule_serializer'

class Payment < ActiveRecord::Base
  include IceCube

  self.inheritance_column = nil

  belongs_to :category

  PAYMENT_TYPES = %w(Spend Receive)

  PAYMENT_PERIODS = %w(Day Week Month)

  validates :name, presence: true

  validates :category, presence: true

  validates :amount, presence: true

  validates :schedule, presence: true

  validates :type, presence: true, inclusion: { in: PAYMENT_TYPES }

  delegate :name, :type, to: :category, prefix: true

  serialize :schedule, ScheduleSerializer.new
end
