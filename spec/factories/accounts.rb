# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :account do
    name 'Eftpos'
    sequence(:number) { |n| "A121234123456712#{n}" }
    type 'Cheque'
    account_group
    archived false
  end
end
