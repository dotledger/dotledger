class SavedSearch < ActiveRecord::Base
  include Taggable

  REVIEW = ['true', 'false'].freeze

  PERIOD_FROM = ['Beginning of year', 'Beginning of quarter', 'Beginning of month', 'Beginning of week'].freeze

  PERIOD_TO = ['End of year', 'End of quarter', 'End of month', 'End of week', 'Today'].freeze

  belongs_to :category

  belongs_to :account

  validates :name, presence: true

  validates :review, inclusion: { in: REVIEW, allow_blank: true }

  validates :period_from, inclusion: { in: PERIOD_FROM, allow_blank: true }

  validates :period_to, inclusion: { in: PERIOD_TO, allow_blank: true }

  validates :category_type, inclusion: { in: Category::CATEGORY_TYPES, allow_blank: true }
end
