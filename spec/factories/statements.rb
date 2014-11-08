# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statement do
    account
    balance '9.99'
  end
end
