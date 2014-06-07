class BalanceCalculator
  attr_reader :account, :number_of_days, :starting_date

  def initialize(options)
    @number_of_days = options.fetch(:number_of_days)
    @account = options.fetch(:account)
    @starting_date = DateTime.now
  end

  def current_balance
    account.balance
  end

  def balances
    @balances ||= [].tap do |output|
      date_range.each do |date|
        balance = current_balance - subsequent_transaction_total(date)
        output << Balance.new(date: date, balance: balance, account_id: account.id)
      end
    end
  end

  def date_range
    (starting_date.to_date - number_of_days.days)..starting_date.to_date
  end

  def subsequent_transaction_total(date)
    account.transactions.where(posted_at: date..starting_date).sum(:amount)
  end

  def as_json(options = {})
    ActiveModel::ArraySerializer.new balances, options
  end
end
