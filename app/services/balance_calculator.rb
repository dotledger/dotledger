class BalanceCalculator
  attr_reader :account, :date_from, :date_to, :date_range

  def initialize(options)
    @account = options.fetch(:account)
    @date_from = options.fetch(:date_from)
    @date_to = options.fetch(:date_to)
    @date_range = date_from..date_to
  end

  def closing_balance
    account.balance - account.transactions.where(['posted_at > ?', date_to]).sum(:amount)
  end

  def balances
    @balances ||= date_range.map do |date|
      Balance.new(date: date, balance: balance_for(date), account_id: account.id)
    end
  end

  def as_json(options = {})
    ActiveModel::Serializer::CollectionSerializer.new balances, options
  end

  private

  def balance_for(date)
    closing_balance - subsequent_transaction_total(date)
  end

  def subsequent_transaction_total(date)
    account.transactions.where(posted_at: date..date_to).sum(:amount)
  end
end
