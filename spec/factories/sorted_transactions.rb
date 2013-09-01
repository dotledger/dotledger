# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sorted_transaction do
    name "MyString"
    transaction
    category nil
    account
  end
end
