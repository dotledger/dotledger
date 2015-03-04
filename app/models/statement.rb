class Statement < ActiveRecord::Base
  belongs_to :account

  has_many :transactions, dependent: :destroy

  validates :balance, presence: true

  validates :account, presence: true
end
