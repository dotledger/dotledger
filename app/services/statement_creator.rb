class StatementCreator
  include Virtus.model

  include ActiveModel::Validations

  attribute :file
  attribute :account

  validates :file, presence: true
  validates :account, presence: true
  validate :file_can_be_parsed

  attr_accessor :statement

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def file_can_be_parsed
    if file.present?
      begin
        OFX::Parser::Base.new(file)
      rescue StandardError => e
        errors.add(:file, 'could not be parsed')
      end
    end
  end

  def persist!
    Statement.transaction do
      create_statement!

      parser.account.transactions.each do |t|
        tr = create_transaction!(t)

        sort_transaction(tr) if tr
      end

      fail ActiveRecord::Rollback if statement.transactions.empty?

      set_statement_dates!

      set_account_balance!

      statement
    end
  end

  def create_transaction!(t)
    new_transaction = Transaction.where(
      amount: t.amount,
      memo: t.memo,
      name: t.name,
      payee: t.payee,
      posted_at: t.posted_at,
      ref_number: t.ref_number,
      type: t.type,
      fit_id: t.fit_id
    ).first_or_initialize

    if new_transaction.new_record?
      new_transaction.account = account
      new_transaction.statement = statement

      new_transaction.save!
      new_transaction
    else
      false
    end
  end

  def create_statement!
    @statement = Statement.create!(
      balance: parser.account.balance.amount,
      account: account
    )
  end

  def set_statement_dates!
    from_date = sorted_transactions.first.posted_at
    to_date = sorted_transactions.last.posted_at
    statement.update!(
      from_date: from_date,
      to_date: to_date
    )
  end

  def parser
    @parser ||= OFX::Parser::Base.new(file).parser
  end

  def sorted_transactions
    statement.transactions.order(:posted_at)
  end

  def set_account_balance!
    if account.statements.order(:to_date).last == statement
      account.update!(balance: statement.balance)
    end
  end

  def sort_transaction(transaction)
    TransactionSorter.new(transaction).sort
  end
end
