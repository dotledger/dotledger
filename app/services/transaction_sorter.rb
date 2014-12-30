class TransactionSorter
  attr_reader :sorted_transaction

  def initialize(transaction)
    @transaction = transaction
  end

  def sort
    return unless rule.present?

    @sorted_transaction = @transaction.create_sorted_transaction!(
      name: name,
      category_id: rule.category_id,
      account_id: @transaction.account_id,
      review: rule.review,
      tag_ids: rule.tag_ids
    )
  end

  def rule
    @rule ||= SortingRule
      .where("? ILIKE ('%' || contains || '%')", @transaction.search)
      .order('LENGTH(contains)')
      .last
  end

  private

  def name
    if rule.present? && rule.name.present?
      rule.name
    else
      @transaction.search
    end
  end
end
