# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sorted_transaction do
    name "MyString"
    account_transaction { FactoryGirl.create :transaction }
    category
    account
  end
end
