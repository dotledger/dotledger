class SortingRule < ActiveRecord::Base
  belongs_to :category

  validates :contains, :presence => true

  validates :category, :presence => true
end
