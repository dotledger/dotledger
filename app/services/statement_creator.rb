class StatementCreator
  include Virtus

  include ActiveModel::Validations

  attribute :file, File
  attribute :account, Account

  validates :file, :presence => true
  validates :account, :presence => true
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
        OFX::Parser::Base.new(self.file)
      rescue StandardError => e
        errors.add(:file, "could not be parsed")
      end
    end
  end

  def persist!
    Statement.transaction do

      create_statement!

      parser.account.transactions.each do |t|
        create_transaction!(t)
      end

      set_statement_dates!

      set_account_balance!

      self.statement
    end
  end

  def create_transaction!(t)
    new_transaction = Transaction.new do |tr|
      %w(amount memo name payee posted_at ref_number type fit_id).each do |m|
        tr.send("#{m}=", t.send(m))
      end
      tr.account = self.account
      tr.statement = self.statement
    end

    new_transaction.save!
  end

  def create_statement!
    @statement = Statement.create!(
      :balance => parser.account.balance.amount,
      :account => self.account
    )
  end

  def set_statement_dates!
    from_date = sorted_transactions.first.posted_at
    to_date = sorted_transactions.last.posted_at
    self.statement.update!(
      :from_date => from_date,
      :to_date => to_date,
    )
  end

  def parser
    @parser ||= OFX::Parser::Base.new(self.file).parser
  end

  def sorted_transactions
    self.statement.transactions.order(:posted_at)
  end

  def set_account_balance!
    if self.account.statements.order(:to_date).last == self.statement
      self.account.update!(:balance => self.statement.balance)
    end
  end
end
