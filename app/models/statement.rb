class Statement < ActiveRecord::Base
  belongs_to :account

  validates :balance, :presence => true

  validates :account, :presence => true
end
