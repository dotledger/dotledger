class StatementCreator
  def initialize(account, file)
    @account = account
    @file = file
  end

  # TODO: handle exceptions
  def call
    Statement.transaction do
      parser = OFX::Parser::Base.new(@file).parser
      statement = Statement.create!(
        :balance => parser.account.balance.amount,
        :account => @account
      )

      parser.account.transactions.each do |t|
        new_transaction = Transaction.new do |tr|
          %w(amount memo name payee posted_at ref_number type fit_id).each do |m|
            tr.send("#{m}=", t.send(m))
          end
          tr.account = @account
          tr.statement = statement
        end

        new_transaction.save!
      end
      statement
    end
  end
end
