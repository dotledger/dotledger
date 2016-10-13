require 'rails_helper'

describe ActivityPerCategoryType do
  let(:date_range) { (Date.parse('2011-01-01')..Date.parse('2011-02-01')) }
  subject { described_class.new(date_range) }

  context 'with no transactions' do
    it 'returns an empty array' do
      expect(subject.activity_per_category_type).to eq []
    end
  end

  context 'with transactions' do
    let!(:category1) { FactoryGirl.create(:category, type: 'Flexible') }
    let!(:category2) { FactoryGirl.create(:category, type: 'Essential') }
    let!(:category3) { FactoryGirl.create(:category, type: 'Income') }
    let!(:transaction1) { FactoryGirl.create(:transaction, posted_at: rand(date_range), amount: -40.0) }
    let!(:sorted_transaction1) { FactoryGirl.create(:sorted_transaction, category_id: category1.id, transaction_id: transaction1.id) }
    let!(:transaction2) { FactoryGirl.create(:transaction, posted_at: rand(date_range), amount: -30.0) }
    let!(:sorted_transaction2) { FactoryGirl.create(:sorted_transaction, category_id: category2.id, transaction_id: transaction2.id) }
    let!(:transaction3) { FactoryGirl.create(:transaction, posted_at: rand(date_range), amount: 50.0) }
    let!(:sorted_transaction3) { FactoryGirl.create(:sorted_transaction, category_id: category3.id, transaction_id: transaction3.id) }
    let!(:transaction4) { FactoryGirl.create(:transaction, posted_at: rand(date_range), amount: -70.0) }

    it 'returns an array with one element' do
      expect(subject.activity_per_category_type.length).to eq 4
    end

    it 'returns the correct spent amount' do
      expect(subject.activity_per_category_type[0]['spent']).to eq 30.0
      expect(subject.activity_per_category_type[1]['spent']).to eq 40.0
      expect(subject.activity_per_category_type[2]['spent']).to eq 0.0
      expect(subject.activity_per_category_type[3]['spent']).to eq 70.0
    end

    it 'returns the correct received amount' do
      expect(subject.activity_per_category_type[0]['received']).to eq 0.0
      expect(subject.activity_per_category_type[1]['received']).to eq 0.0
      expect(subject.activity_per_category_type[2]['received']).to eq 50.0
      expect(subject.activity_per_category_type[3]['received']).to eq 0.0
    end

    it 'returns the correct net amount' do
      expect(subject.activity_per_category_type[0]['net']).to eq(-30.0)
      expect(subject.activity_per_category_type[1]['net']).to eq(-40.0)
      expect(subject.activity_per_category_type[2]['net']).to eq(50.0)
      expect(subject.activity_per_category_type[3]['net']).to eq(-70.0)
    end

    it 'returns the correct category type' do
      expect(subject.activity_per_category_type[0]['type']).to eq "Essential"
      expect(subject.activity_per_category_type[1]['type']).to eq "Flexible"
      expect(subject.activity_per_category_type[2]['type']).to eq "Income"
      expect(subject.activity_per_category_type[3]['type']).to eq "Uncategorised"
    end
  end
end
