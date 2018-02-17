# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :sorting_rule do
    sequence(:contains) { |n| "Contains #{n}" }
    sequence(:name) { |n| "Name #{n}" }
    category
  end
end
