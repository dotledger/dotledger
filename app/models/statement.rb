class Statement < ActiveRecord::Base
  belongs_to :account

  has_many :transactions, dependent: :restrict_with_error

  validates :balance, presence: true

  validates :account, presence: true
end
