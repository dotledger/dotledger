require 'spec_helper'

describe Account do
  before do
    FactoryGirl.create :account
  end

  it { should have_db_column(:name).of_type(:string).with_options(:null => false) }

  it { should have_db_column(:number).of_type(:string).with_options(:null => false) }

  it { should have_db_column(:type).of_type(:string).with_options(:null => false) }

  it { should have_db_index(:number).unique(:true) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :number }

  it { should validate_presence_of :type }

  it { should validate_uniqueness_of :number }

  it { should ensure_inclusion_of(:type).in_array(['Cheque', 'Savings', 'Credit Card', 'Other']) }
end
