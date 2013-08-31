class Transaction < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :account

  belongs_to :statement

  validates :amount, :presence => true

  validates :fit_id, :presence => true

  validates :account, :presence => true
end
