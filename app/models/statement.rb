class Statement < ActiveRecord::Base
  belongs_to :account

  has_many :transactions

  validates :balance, :presence => true

  validates :account, :presence => true
end
