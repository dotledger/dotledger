require 'rails_helper'

describe AccountGroup do
  before do
    FactoryGirl.create :account_group
  end

  it { should have_db_column(:name).of_type(:string).with_options(null: false) }

  it { should have_db_index(:name).unique(:true) }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }

  it { should have_many(:accounts).dependent(:restrict_with_error) }
end
