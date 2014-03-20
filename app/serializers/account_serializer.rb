class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :type, :updated_at, :balance,
    :unsorted_transaction_count, :sorted_transaction_count, :review_transaction_count,
    :balances

  def unsorted_transaction_count
    object.transactions.unsorted.count
  end

  def sorted_transaction_count
    object.transactions.not_for_review.sorted.count
  end

  def review_transaction_count
    object.transactions.for_review.count
  end

  # FIXME: This is a bit hacky
  def balances
    starting_balance = balance
    starting_date = DateTime.now

    {}.tap do |output|
      (90.days.ago.to_date..starting_date.to_date).each do |date|
        output[date] = starting_balance - (object.transactions.where(:posted_at => date..starting_date).sum(:amount))
      end
    end
  end
end
