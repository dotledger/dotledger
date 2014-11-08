# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sorting_rule do
    contains 'MyString'
    name 'MyString'
    category
  end
end
