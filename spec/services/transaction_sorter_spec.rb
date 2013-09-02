require 'spec_helper'

describe TransactionSorter do
  let!(:transaction) { FactoryGirl.create :transaction, :name => "Some Transaction Foobar" }
  let!(:best_rule) { FactoryGirl.create :sorting_rule, :contains => 'Some Transaction' }
  let!(:second_best_rule) { FactoryGirl.create :sorting_rule, :contains => 'Transaction' }
  let!(:least_best_rule) { FactoryGirl.create :sorting_rule, :contains => 'Action' }

  subject { TransactionSorter.new(transaction) }

  it "should find the best rule for sorting" do
    expect(subject.rule).to eq best_rule
  end

  it "should create a sorted_transaction" do
    expect {
      subject.sort
    }.to change(SortedTransaction, :count).by(1)
  end

  it "should use the rule name if present" do
    best_rule.update(:name => "New Name")
    subject.sort
    expect(subject.sorted_transaction.name).to eq best_rule.name
  end

  it "should use the transaction search if rule name is blank" do
    best_rule.update(:name => nil)
    subject.sort
    expect(subject.sorted_transaction.name).to eq transaction.search
  end
end
