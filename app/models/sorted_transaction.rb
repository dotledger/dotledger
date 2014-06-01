class SortedTransaction < ActiveRecord::Base
  include Taggable

  belongs_to :account_transaction, class_name: 'Transaction', foreign_key: 'transaction_id'

  belongs_to :category

  belongs_to :account

  validates :name, presence: true

  validates :account, presence: true

  validates :account_transaction, presence: true

  validates :category, presence: true

  delegate :name, to: :category, prefix: true
end
