class Transaction < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :account

  belongs_to :statement

  has_one :sorted_transaction

  validates :amount, presence: true

  validates :fit_id, presence: true

  validates :account, presence: true

  validates :search, presence: true

  before_validation :set_search

  scope :unsorted, proc {
    includes(:sorted_transaction).where(sorted_transactions: { id: nil })
  }

  scope :sorted, proc {
    includes(:sorted_transaction).where.not(sorted_transactions: { id: nil }).references(:sorted_transactions)
  }

  scope :for_review, proc {
    includes(:sorted_transaction).where(sorted_transactions: { review: true })
  }

  scope :not_for_review, proc {
    includes(:sorted_transaction).where(sorted_transactions: { review: false })
  }

  # FIXME: Solr, Sphinx, ElasticSearch...?
  scope :search_query, proc {|search_query|
    transactions = Transaction.arel_table
    sorted_transactions = SortedTransaction.arel_table
    wildcard_search_query = "%#{search_query}%"
    #includes(:sorted_transaction).where(['sorted_transactions.name ILIKE ?', "%#{search_query}%"])
    includes(:sorted_transaction).
      where(
        transactions[:name].matches(wildcard_search_query).
        or(sorted_transactions[:name].matches(wildcard_search_query))
      )
  }

  scope :with_category, proc {|category_id|
    includes(:sorted_transaction).where(sorted_transactions: { category_id: category_id })
  }

  scope :between_dates, proc {|date_from, date_to|
    includes(:sorted_transaction).where(posted_at: (Date.parse(date_from)..Date.parse(date_to)))
  }

  scope :with_tags, proc {|tag_ids|
    tag_ids = Array(tag_ids).flatten.map(&:to_i)
    includes(:sorted_transaction).
    where([tag_ids.map { "? = ANY(sorted_transactions.tag_ids)" }.join(' OR '), *tag_ids])
  }

  private

  def set_search
    self.search = "#{name} #{memo}".strip.titleize.gsub(/\s+/, ' ')
  end
end
