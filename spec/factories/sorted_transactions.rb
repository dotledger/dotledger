# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :sorted_transaction do
    name 'MyString'
    account_transaction { FactoryBot.create :transaction }
    category
    account
  end
end
