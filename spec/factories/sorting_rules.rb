# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sorting_rule do
    sequence(:contains) { |n| "Contains #{n}" }
    sequence(:name) { |n| "Name #{n}" }
    category
  end
end
