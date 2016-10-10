require 'rails_helper'

describe Category do
  before do
    FactoryGirl.create :category
  end

  it { should have_db_column(:name).of_type(:string).with_options(null: false) }

  it { should have_db_column(:type).of_type(:string).with_options(null: false) }

  it { should have_db_index(:name).unique(:true) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :type }

  it { should validate_uniqueness_of :name }

  it { should validate_inclusion_of(:type).in_array(%w(Flexible Essential Income Transfer)) }

  it { should have_many(:sorted_transactions).dependent(:restrict_with_error) }

  it { should have_many(:sorting_rules).dependent(:restrict_with_error) }

  it { should have_many(:payments).dependent(:restrict_with_error) }

  it { should have_one(:goal).dependent(:destroy) }

  it 'creates a related goal' do
    expect do
      FactoryGirl.create :category
    end.to change(Goal, :count).by(1)
  end
end
