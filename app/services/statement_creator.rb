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
      parser = OFX::Parser::Base.new(self.file).parser
      @statement = Statement.create!(
        :balance => parser.account.balance.amount,
        :account => self.account
      )

      parser.account.transactions.each do |t|
        new_transaction = Transaction.new do |tr|
          %w(amount memo name payee posted_at ref_number type fit_id).each do |m|
            tr.send("#{m}=", t.send(m))
          end
          tr.account = self.account
          tr.statement = statement
        end

        new_transaction.save!
      end
      statement
    end
  end
end
