class AccountGroup < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :accounts, dependent: :restrict_with_error
end
