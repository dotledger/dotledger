require 'rails_helper'
require 'tempfile'

describe DotLedgerImporter do
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

  let(:file) do
    Tempfile.new('yaml').tap do |file|
      file.write(data.to_yaml)
      file.rewind
    end
  end
  subject { described_class.new(file) }

  it 'imports the accounts' do
    expect do
      subject.import
    end.to change(Account, :count).by(1)

    expect(subject.data['Accounts'].last.name).to eq('Eftpos')
  end

  it 'imports the categories' do
    expect do
      subject.import
    end.to change(Category, :count).by(1)

    expect(subject.data['Categories'].last.name).to eq('Category 1')
  end

  it 'imports the goals' do
    expect do
      subject.import
    end.to change(Goal, :count).by(1)

    expect(subject.data['Goals'].last.amount).to eq(123.45)
  end

  it 'imports the sorting rules' do
    expect do
      subject.import
    end.to change(SortingRule, :count).by(1)

    expect(subject.data['SortingRules'].last.name).to eq('Name 1')
  end
end
