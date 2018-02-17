# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    type 'Essential'
  end
end
