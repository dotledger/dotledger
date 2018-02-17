# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :tag do
    sequence(:name) { |i| "tag #{i}" }
  end
end
