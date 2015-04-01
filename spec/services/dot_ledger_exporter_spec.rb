require 'rails_helper'

describe DotLedgerExporter do
  let!(:account) do
    FactoryGirl.create :account, name: 'Eftpos', number: '1212341234567121', type: 'Cheque'
  end
  let!(:category) do
    FactoryGirl.create :category, name: 'Category 1', type: 'Essential'
  end
  let!(:goal) do
    category.goal.update_attributes(amount: 123.45)
  end
  let!(:SortingRule) do
    FactoryGirl.create :sorting_rule, name: 'Name 1', contains: 'Contains 1', category: category, tag_list: %w(foo bar), review: true
  end

  let(:data) do
    {
      'Accounts' => [
        {
          'name' => 'Eftpos',
          'number' => '1212341234567121',
          'type' => 'Cheque'
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
