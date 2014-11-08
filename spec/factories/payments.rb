# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    sequence(:name) {|n| "MyString #{n}" }
    category
    amount 9.99
    type 'Spend'
  end
end
