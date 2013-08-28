# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    amount 10.00
    sequence(:fit_id)
    memo "Memo"
    name "Name"
    payee "Payee"
    posted_at DateTime.now
    account
  end
end
