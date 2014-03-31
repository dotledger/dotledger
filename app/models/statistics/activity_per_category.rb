# FIXME: This needs some work

module Statistics
  class ActivityPerCategory < Struct.new(:date_range)
    def as_json(*)
      query.map(&:attributes)
    end

    private
    def select_list
      <<-EOT
      categories.id AS id,
      categories.type AS type,
      categories.NAME AS NAME,
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
      @query ||= Category.joins(:goal, sorted_transactions: :transaction).
        where(transactions: {posted_at: date_range}).
        select(select_list).
        group('categories.id, categories.name, categories.type, goals.amount, goals.period').
        order(:name)
    end
  end
end
