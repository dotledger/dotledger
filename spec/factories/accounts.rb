# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    name 'Eftpos'
    sequence(:number) { |n| "A121234123456712#{n}" }
    type 'Cheque'
  end
end
