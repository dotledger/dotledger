# FIXME: This needs some work

class ActivityPerCategory
  attr_reader :date_range

  def initialize(date_range)
    @date_range = date_range
  end

  def as_json(options = {})
    ActiveModel::Serializer::CollectionSerializer.new activity_per_category, options
  end

  def activity_per_category
    query.map do |row|
      CategoryActivity.new(row.attributes)
    end
  end

  def total_spent
    query.inject(0) {|memo, category| category.spent + memo }
  end

  def total_received
    query.inject(0) {|memo, category| category.received + memo }
  end

  def total_net
    query.inject(0) {|memo, category| category.net + memo }
  end

  private

  def select_list
    <<-EOT
    categories.id AS id,
    categories.type AS type,
    categories.name AS name,
    goals.amount AS goal_amount,
    goals.period AS goal_period,
    (CASE
    WHEN goals.period = 'Week'
    THEN goals.amount * #{Goal::WEEK_MULTIPLIER}
    WHEN goals.period = 'Fortnight'
    THEN goals.amount * #{Goal::FORTNIGHT_MULTIPLIER}
    ELSE goals.amount
    END) AS goal,
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

  def query
    @query ||=
      Category.joins(:goal, sorted_transactions: :account_transaction)
      .where(transactions: { posted_at: date_range })
      .select(select_list)
      .group('categories.id, categories.name, categories.type, goals.amount, goals.period')
      .order(:name)
  end
end