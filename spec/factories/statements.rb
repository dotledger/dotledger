# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :statement do
    account
    balance '9.99'
  end
end
