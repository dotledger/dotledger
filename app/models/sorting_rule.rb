class SortingRule < ActiveRecord::Base
  include Taggable

  belongs_to :category

  validates :contains, presence: true

  validates :category, presence: true

  delegate :name, to: :category, prefix: true
end
