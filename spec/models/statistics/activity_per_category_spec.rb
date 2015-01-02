require 'rails_helper'

describe Statistics::ActivityPerCategory do
  let(:date_range) { (Date.parse('2011-01-01')..Date.parse('2011-02-01')) }
  subject { Statistics::ActivityPerCategory.new(date_range) }

  context 'with no transactions' do
    it 'returns an empty array' do
      expect(subject.as_json).to eq []
    end
  end

  context 'with transactions for one category' do
    let!(:category) { FactoryGirl.create(:category) }
    let!(:transaction1) { FactoryGirl.create(:transaction, posted_at: rand(date_range), amount: -40.0) }
    let!(:sorted_transaction1) { FactoryGirl.create(:sorted_transaction, category_id: category.id, transaction_id: transaction1.id) }
    let!(:transaction2) { FactoryGirl.create(:transaction, posted_at: rand(date_range), amount: 30.0) }
    let!(:sorted_transaction2) { FactoryGirl.create(:sorted_transaction, category_id: category.id, transaction_id: transaction2.id) }

    before do
      category.goal.update_attributes(amount: 100, period: 'Week')
    end

    it 'returns an array with one element' do
      expect(subject.as_json.length).to eq 1
    end

    it 'returns the correct adjusted goal amount' do
      expect(subject.as_json.first['goal']).to eq 100 * Goal::WEEK_MULTIPLIER
    end

    it 'returns the correct spent amount' do
      expect(subject.as_json.first['spent']).to eq 40.0
    end

    it 'returns the correct received amount' do
      expect(subject.as_json.first['received']).to eq 30.0
    end

    it 'returns the correct net amount' do
      expect(subject.as_json.first['net']).to eq(-10.0)
    end

    it 'returns the correct category name' do
      expect(subject.as_json.first['name']).to eq category.name
    end

    it 'returns the correct category type' do
      expect(subject.as_json.first['type']).to eq category.type
    end

    it 'returns the correct category id' do
      expect(subject.as_json.first['id']).to eq category.id
    end

    it 'returns the correct goal amount' do
      expect(subject.as_json.first['goal_amount']).to eq category.goal.amount
    end

    it 'returns the correct goal period' do
      expect(subject.as_json.first['goal_period']).to eq category.goal.period
    end
  end
end
