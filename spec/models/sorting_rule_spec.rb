require 'spec_helper'

describe SortingRule do
  it { should have_db_column(:contains).of_type(:string).with_options(:null => false) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(:null => false) }

  it { should have_db_column(:name).of_type(:string).with_options(:default => nil) }

  it { should have_db_index(:contains).unique(:true) }

  it { should validate_presence_of :contains }

  it { should validate_presence_of :category }

  it { should belong_to :category }
end
