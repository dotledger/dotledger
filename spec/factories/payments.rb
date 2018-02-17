# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :payment do
    sequence(:name) { |n| "MyString #{n}" }
    category
    amount 9.99
    type 'Spend'
    schedule { IceCube::Schedule.new }
  end
end
