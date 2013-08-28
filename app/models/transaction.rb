class Transaction < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :account

  validates :amount, :presence => true

  validates :fit_id, :presence => true

  validates :account, :presence => true

  # TODO: handle exceptions
  def self.import(file, account)
    new_transactions = []

    transaction do
      parser = OFX::Parser::Base.new(file).parser

      parser.account.transactions.each do |t|
        new_transaction = Transaction.new do |tr|
          %w(amount memo name payee posted_at ref_number type fit_id).each do |m|
            tr.send("#{m}=", t.send(m))
          end
          tr.account = account
        end

        new_transaction.save!

        new_transactions << new_transaction
      end
    end

    new_transactions
  end
end
