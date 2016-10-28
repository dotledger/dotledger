require 'rails_helper'

describe DotLedgerExporter do
  let!(:account_group) do
    FactoryGirl.create :account_group, name: 'Savings'
  end
  let!(:account) do
    FactoryGirl.create :account, name: 'Eftpos', number: '1212341234567121', type: 'Cheque', account_group: nil
  end
  let!(:account_2) do
    FactoryGirl.create :account, name: 'Savings', number: '1212341234567122', type: 'Savings', account_group: account_group
  end
  let!(:category) do
    FactoryGirl.create :category, name: 'Category 1', type: 'Essential'
  end
  let!(:goal) do
    category.goal.update_attributes(amount: 123.45)
  end
  let!(:sorting_rule) do
    FactoryGirl.create :sorting_rule, name: 'Name 1', contains: 'Contains 1', category: category, tag_list: %w(foo bar), review: true
  end

  let(:data) do
    {
      'AccountGroups' => [
        {
          'name' => 'Savings'
        }
      ],
      'Accounts' => [
        {
          'name' => 'Eftpos',
          'number' => '1212341234567121',
          'type' => 'Cheque',
          'account_group_name' => nil
        },
        {
          'name' => 'Savings',
          'number' => '1212341234567122',
          'type' => 'Savings',
          'account_group_name' => 'Savings'
        }
      ],
      'Categories' => [
        {
          'name' => 'Category 1',
          'type' => 'Essential'
        }
      ],
      'Goals' => [
        {
          'category_name' => 'Category 1',
          'type' => 'Spend',
          'amount' => 123.45,
          'period' => 'Month'
        }
      ],
      'SortingRules' => [
        {
          'name' => 'Name 1',
          'contains' => 'Contains 1',
          'category_name' => 'Category 1',
          'tag_list' => %w(foo bar),
          'review' => true
        }
      ]
    }
  end

  subject { described_class.new }

  it 'builds the correct data format' do
    subject.export

    expect(subject.data).to eq(data)
  end
end
