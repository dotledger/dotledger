FactoryGirl.define do
  factory :account_group do
    sequence(:name) { |n| "Group #{n}" }
  end
end
