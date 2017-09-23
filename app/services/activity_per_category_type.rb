# FIXME: This also needs some work

class ActivityPerCategoryType
  attr_reader :date_range

  def initialize(date_range)
    @date_range = date_range
  end

  def as_json(options = {})
    ActiveModel::Serializer::CollectionSerializer.new activity_per_category_type, options
  end

  def activity_per_category_type
    query.map do |row|
      CategoryTypeActivity.new(row.attributes.except('id'))
    end
  end

  def total_spent
    query.inject(0) { |memo, record| record.spent + memo }
  end

  def total_received
    query.inject(0) { |memo, record| record.received + memo }
  end

  def total_net
    query.inject(0) { |memo, record| record.net + memo }
  end

  private

  def select_list
    <<-EOT
    coalesce(categories.type, 'Uncategorised') AS type,
    SUM(CASE
      WHEN transactions.amount > 0
      THEN transactions.amount
      ELSE 0.0
      END) AS received,
    SUM(CASE
      WHEN transactions.amount < 0
      THEN transactions.amount
      ELSE 0.0
      END) * - 1 AS spent,
    SUM(transactions.amount) AS net
    EOT
  end

  def joins_list
    <<-EOT
    LEFT JOIN "sorted_transactions" on "sorted_transactions"."transaction_id" = "transactions"."id"
    LEFT JOIN "categories" on "categories"."id" = "sorted_transactions"."category_id"
    EOT
  end

  def query
    @query ||= Transaction.joins(joins_list)
      .where(posted_at: date_range)
      .select(select_list)
      .group('categories.type')
      .order('categories.type')
  end
end
