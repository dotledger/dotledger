require 'spec_helper'

describe Transaction do
  it { should have_db_column(:amount).of_type(:decimal).with_options(:null => false, :precision => 10, :scale => 2) }

  it { should have_db_column(:fit_id).of_type(:string).with_options(:null => false) }

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

  it { should belong_to :account }

  it { should belong_to :statement }

  describe "#import" do
    let(:file) { File.open("#{fixture_path}/example.ofx") }
    let(:account) { FactoryGirl.create :account }

    it "should import transactions from a file" do
      expect {
        Transaction.import(file, account)
      }.to change(Transaction, :count).by(4)
    end
  end
end
