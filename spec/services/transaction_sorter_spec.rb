require 'rails_helper'

describe TransactionSorter do
  let!(:transaction) { FactoryBot.create :transaction, name: 'Some Transaction Foobar' }
  let!(:best_rule) { FactoryBot.create :sorting_rule, contains: 'Some Transaction' }
  let!(:second_best_rule) { FactoryBot.create :sorting_rule, contains: 'Transaction' }
  let!(:least_best_rule) { FactoryBot.create :sorting_rule, contains: 'Action' }

  subject { described_class.new(transaction) }

  it 'finds the best rule for sorting' do
    expect(subject.rule).to eq best_rule
  end

  it 'creates a sorted_transaction' do
    expect do
      subject.sort
    end.to change(SortedTransaction, :count).by(1)
  end

  it 'uses the rule name if present' do
    best_rule.update(name: 'New Name')
    subject.sort
    expect(subject.sorted_transaction.name).to eq best_rule.name
  end

  it 'uses the transaction search if rule name is blank' do
    best_rule.update(name: nil)
    subject.sort
    expect(subject.sorted_transaction.name).to eq transaction.search
  end

  it 'flags the sorted transaction for review if review is true on the rule' do
    best_rule.update(review: true)
    subject.sort
    expect(subject.sorted_transaction.review).to eq true
  end
end
