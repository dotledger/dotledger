class Account < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :account_group

  has_many :transactions, dependent: :destroy

  has_many :statements, dependent: :destroy

  has_many :sorted_transactions, dependent: :destroy

  ACCOUNT_TYPES = ['Cheque', 'Savings', 'Credit Card', 'Other']

  validates :name, presence: true

  validates :number, presence: true, uniqueness: true

  validates :type, presence: true, inclusion: { in: ACCOUNT_TYPES }

  delegate :name, to: :account_group, prefix: true, allow_nil: true
end
