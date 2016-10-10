require 'rails_helper'

describe Account do
  before do
    FactoryGirl.create :account
  end

  it { should have_db_column(:name).of_type(:string).with_options(null: false) }

  it { should have_db_column(:number).of_type(:string).with_options(null: false) }

  it { should have_db_column(:type).of_type(:string).with_options(null: false) }

  it { should have_db_column(:balance).of_type(:decimal).with_options(precision: 10, scale: 2, null: false, default: 0.0) }

  it { should have_db_index(:number).unique(:true) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :number }

  it { should validate_presence_of :type }

  it { should validate_uniqueness_of :number }

  it { should validate_inclusion_of(:type).in_array(['Cheque', 'Savings', 'Credit Card', 'Other']) }

  it { should have_many(:transactions).dependent(:restrict_with_error) }

  it { should have_many(:statements).dependent(:restrict_with_error) }

  it { should have_many(:sorted_transactions).dependent(:restrict_with_error) }
end
