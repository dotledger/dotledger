require 'spec_helper'

describe Transaction do
  it { should have_db_column(:amount).of_type(:decimal).with_options(:null => false, :precision => 10, :scale => 2) }

  it { should have_db_column(:fit_id).of_type(:string).with_options(:null => false) }

  it { should have_db_column(:search).of_type(:string).with_options(:null => false) }

  it { should have_db_column(:memo).of_type(:string) }

  it { should have_db_column(:payee).of_type(:string) }

  it { should have_db_column(:name).of_type(:string) }

  it { should have_db_column(:posted_at).of_type(:datetime) }

  it { should have_db_column(:ref_number).of_type(:string) }

  it { should have_db_column(:type).of_type(:string) }

  it { should have_db_column(:account_id).of_type(:integer).with_options(:null => false) }

  it { should validate_presence_of :amount }
  
  it { should validate_presence_of :fit_id }

  it { should validate_presence_of :account }

  it { should validate_presence_of :search }

  it { should belong_to :account }

  it { should belong_to :statement }

  it { should have_one :sorted_transaction }

  it "should set the search attribute before validation" do
    transaction = FactoryGirl.build :transaction, :name => "FOO", :memo => "BAR"

    expect {
      transaction.valid?
    }.to change(transaction, :search).from(nil).to("Foo Bar")
  end

  describe "#unsorted" do
    let!(:unsorted) { FactoryGirl.create_list :transaction, 2 }
    let!(:sorted) { FactoryGirl.create_list :transaction, 2 }

    before do
      category = FactoryGirl.create :category
      sorted.each do |t|
        t.create_sorted_transaction!(
          :name => t.search,
          :category => category,
          :account => t.account
        )
      end
    end

    it "should not include sorted transactions" do
      expect(Transaction.unsorted).to match_array unsorted
    end
  end

  describe "#sorted" do
    let!(:unsorted) { FactoryGirl.create_list :transaction, 2 }
    let!(:sorted) { FactoryGirl.create_list :transaction, 2 }

    before do
      category = FactoryGirl.create :category
      sorted.each do |t|
        t.create_sorted_transaction!(
          :name => t.search,
          :category => category,
          :account => t.account
        )
      end
    end

    it "should not include unsorted transactions" do
      expect(Transaction.sorted).to match_array sorted
    end
  end
end
