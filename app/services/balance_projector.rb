class BalanceProjector
  attr_reader :opening_balance, :date_from, :date_to, :date_range

  def initialize(options)
    @opening_balance = options.fetch(:opening_balance)
    @date_from = options.fetch(:date_from)
    @date_to = options.fetch(:date_to)
    @date_range = date_from..date_to
  end

  def as_json(options = {})
    balances
  end

  def balances
    sum = opening_balance
    @balances ||= date_range.map do |date|
      balance = payments.select do |payment|
        payment.schedule.occurs_on? date
      end.reduce(0.0) do |m,payment|
        amount =
          if payment.type == 'Receive'
            payment.amount
          else
            -payment.amount
          end
        m + amount
      end
      {
        balance: (sum += balance),
        date: date
      }
    end
  end

  private

  def payments
    @payments ||= Payment.all
  end
end
