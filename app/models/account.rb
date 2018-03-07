class Account < ActiveRecord::Base
  self.inheritance_column = nil

  scope :unarchived, proc { unscoped.where(archived: false) }

  scope :archived, proc { unscoped.where(archived: true) }

  belongs_to :account_group

  has_many :transactions, dependent: :restrict_with_error

  has_many :statements, dependent: :restrict_with_error

  has_many :sorted_transactions, dependent: :restrict_with_error

  ACCOUNT_TYPES = ['Cheque', 'Savings', 'Credit Card', 'Other'].freeze

  validates :name, presence: true

  validates :number, presence: true, uniqueness: true

  validates :type, presence: true, inclusion: { in: ACCOUNT_TYPES }

  delegate :name, to: :account_group, prefix: true, allow_nil: true
end
