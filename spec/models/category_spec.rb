require 'spec_helper'

describe Category do
  before do
    FactoryGirl.create :category
  end

  it { should have_db_column(:name).of_type(:string).with_options(:null => false) }

  it { should have_db_column(:type).of_type(:string).with_options(:null => false) }

  it { should have_db_index(:name).unique(:true) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :type }

  it { should validate_uniqueness_of :name }

  it { should ensure_inclusion_of(:type).in_array(['Flexible', 'Essential', 'Income']) }
end
