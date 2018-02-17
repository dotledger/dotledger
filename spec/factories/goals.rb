# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :goal do
    category
    amount 1000
    period 'Month'
    type 'Spend'
  end
end
