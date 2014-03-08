require 'spec_helper'

describe Tag do
  before do
    FactoryGirl.create :tag
  end

  it { should have_db_column(:name).of_type(:string).with_options(:null => false) }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }
end
