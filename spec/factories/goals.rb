# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    category
    amount 1000
    period 'Month'
  end
end
