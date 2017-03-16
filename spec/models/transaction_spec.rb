require 'rails_helper'

describe Transaction do
  it { should have_db_column(:amount).of_type(:decimal).with_options(null: false, precision: 10, scale: 2) }

  it { should have_db_column(:fit_id).of_type(:string).with_options(null: false) }

  it { should have_db_column(:search).of_type(:string).with_options(null: false) }

  it { should have_db_column(:memo).of_type(:string) }

  it { should have_db_column(:payee).of_type(:string) }

  it { should have_db_column(:name).of_type(:string) }

  it { should have_db_column(:posted_at).of_type(:datetime) }

  it { should have_db_column(:ref_number).of_type(:string) }

  it { should have_db_column(:type).of_type(:string) }

  it { should have_db_column(:account_id).of_type(:integer).with_options(null: false) }

  it { should validate_presence_of :amount }

  it { should validate_presence_of :fit_id }

  it { should validate_presence_of :account }

  it { should validate_presence_of :search }

  it { should belong_to :account }

  it { should belong_to :statement }

  it { should have_one :sorted_transaction }

  it 'sets the search attribute before validation' do
    transaction = FactoryGirl.build :transaction, name: 'FOO', memo: 'BAR'

    expect do
      transaction.valid?
    end.to change(transaction, :search).from(nil).to('Foo Bar')
  end

  describe '#unsorted' do
    let!(:unsorted) { FactoryGirl.create_list :transaction, 2 }
    let!(:sorted) { FactoryGirl.create_list :transaction, 2 }

    before do
      category = FactoryGirl.create :category
      sorted.each do |t|
        t.create_sorted_transaction!(
          name: t.search,
          category: category,
          account: t.account
        )
      end
    end

    it 'does not include sorted transactions' do
      expect(described_class.unsorted).to match_array unsorted
    end
  end

  describe '#sorted' do
    let!(:unsorted) { FactoryGirl.create_list :transaction, 2 }
    let!(:sorted) { FactoryGirl.create_list :transaction, 2 }
    let!(:category) { FactoryGirl.create :category }

    before do
      sorted.each do |t|
        t.create_sorted_transaction!(
          name: t.search,
          category: category,
          account: t.account
        )
      end
    end

    it 'does not include unsorted transactions' do
      expect(described_class.sorted).to match_array sorted
    end
  end

  describe '#with_category' do
    let!(:transactions_1) { FactoryGirl.create_list :transaction, 2 }
    let!(:transactions_2) { FactoryGirl.create_list :transaction, 2 }
    let!(:category_1) { FactoryGirl.create :category }
    let!(:category_2) { FactoryGirl.create :category }

    before do
      transactions_1.each do |t|
        t.create_sorted_transaction!(
          name: t.search,
          category: category_1,
          account: t.account
        )
      end
    end

    it 'only includes transactions with the correct category' do
      expect(described_class.with_category(category_1.id)).to match_array transactions_1
    end
  end

  describe '#with_category_type' do
    let!(:transactions_1) { FactoryGirl.create_list :transaction, 2 }
    let!(:transactions_2) { FactoryGirl.create_list :transaction, 2 }
    let!(:transactions_3) { FactoryGirl.create_list :transaction, 2 }
    let!(:category_1) { FactoryGirl.create :category, type: 'Essential' }
    let!(:category_2) { FactoryGirl.create :category, type: 'Essential' }
    let!(:category_3) { FactoryGirl.create :category, type: 'Flexible' }

    before do
      transactions_1.each do |t|
        t.create_sorted_transaction!(
          name: t.search,
          category: category_1,
          account: t.account
        )
      end

      transactions_2.each do |t|
        t.create_sorted_transaction!(
          name: t.search,
          category: category_2,
          account: t.account
        )
      end
    end

    it 'only includes transactions with the correct category type' do
      expect(described_class.with_category_type('Essential')).to match_array(transactions_1 + transactions_2)
    end
  end

  describe '#between_dates' do
    let!(:transaction_before) { FactoryGirl.create :transaction, posted_at: Date.parse('2012-03-05') }
    let!(:transaction_during) { FactoryGirl.create :transaction, posted_at: Date.parse('2012-04-10') }
    let!(:transaction_after) { FactoryGirl.create :transaction, posted_at: Date.parse('2012-05-20') }

    it 'only includes transaction within the date range' do
      date_from = '2012-04-01'
      date_to = '2012-04-30'

      expect(described_class.between_dates(date_from, date_to)).to match_array [transaction_during]
    end
  end

  describe '#search_query' do
    let!(:transaction_match_1) { FactoryGirl.create :transaction, name: 'Foobar', memo: 'Test-Baz' }
    let!(:transaction_match_2) { FactoryGirl.create :transaction, sorted_transaction: FactoryGirl.create(:sorted_transaction, name: 'Some Test Baz Name') }
    let!(:transaction_no_match_1) { FactoryGirl.create :transaction, name: 'Foobar' }
    let!(:transaction_no_match_2) { FactoryGirl.create :transaction, sorted_transaction: FactoryGirl.create(:sorted_transaction, name: 'Some Name') }

    it 'only includes transaction that match the search query' do
      expect(described_class.search_query('Test')).to match_array [transaction_match_1, transaction_match_2]
      expect(described_class.search_query('Test Baz')).to match_array [transaction_match_1, transaction_match_2]
      expect(described_class.search_query('Test-Baz')).to match_array [transaction_match_1]
    end

    it 'only includes transaction that match the search query, case insensitive' do
      expect(described_class.search_query('test')).to match_array [transaction_match_1, transaction_match_2]
      expect(described_class.search_query('TEST BAZ')).to match_array [transaction_match_1, transaction_match_2]
      expect(described_class.search_query('test-baz')).to match_array [transaction_match_1]
    end
  end

  describe '#with_tags' do
    let!(:tag_1) { FactoryGirl.create :tag }
    let!(:tag_2) { FactoryGirl.create :tag }
    let!(:transaction_match_1) { FactoryGirl.create :transaction, sorted_transaction: FactoryGirl.create(:sorted_transaction, tag_ids: [tag_1.id, tag_2.id]) }
    let!(:transaction_match_2) { FactoryGirl.create :transaction, sorted_transaction: FactoryGirl.create(:sorted_transaction, tag_ids: [tag_1.id, tag_2.id]) }
    let!(:transaction_no_match) { FactoryGirl.create :transaction }

    it 'only includes transaction that have all the correct tags' do
      expect(described_class.with_tags([tag_1.id, tag_2.id])).to match_array [transaction_match_1, transaction_match_2]
    end

    it 'only includes transaction that have one correct tag' do
      expect(described_class.with_tags([tag_1.id])).to match_array [transaction_match_1, transaction_match_2]
    end
  end
end
