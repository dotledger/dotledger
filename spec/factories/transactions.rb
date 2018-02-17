# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :transaction do
    amount 10.00
    sequence(:fit_id)
    memo 'Memo'
    name 'Name'
    payee 'Payee'
    posted_at DateTime.now
    account

    factory :transaction_sorted do
      after(:create) do |transaction|
        FactoryBot.create :sorted_transaction,
          account_transaction: transaction,
          name: transaction.search
      end
    end

    factory :transaction_review do
      after(:create) do |transaction|
        FactoryBot.create :sorted_transaction,
          review: true,
          account_transaction: transaction,
          name: transaction.search
      end
    end
  end
end
