class SortingRule < ActiveRecord::Base
  include Taggable

  belongs_to :category

  validates :contains, presence: true

  validates :category, presence: true

  delegate :name, to: :category, prefix: true

  scope :with_category, proc { |category_id|
    where(category_id: category_id)
  }

  scope :with_category_type, proc { |category_type|
    includes(:category).where(categories: { type: category_type })
  }

  scope :with_tags, proc { |tag_ids|
    tag_ids = Array(tag_ids).flatten.map(&:to_i)
    where([tag_ids.map { '? = ANY(tag_ids)' }.join(' OR '), *tag_ids])
  }

  scope :search_query, proc { |search_query|
    table = SortingRule.arel_table
    wildcard_search_query = "%#{search_query}%"

    where(
      table[:name].matches(wildcard_search_query)
      .or(table[:contains].matches(wildcard_search_query))
    )
  }
end
