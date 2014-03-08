require 'spec_helper'

describe SortedTransaction do
  it { should have_db_column(:account_id).of_type(:integer).with_options(:null => false) }

  it { should have_db_column(:transaction_id).of_type(:integer).with_options(:null => false) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(:null => false) }

  it { should have_db_column(:tag_ids).of_type(:integer).with_options(:array => true) }

  it { should have_db_column(:review).of_type(:boolean).with_options(:default => false, :null => false) }

  it { should have_db_column(:name).of_type(:string) }

  it { should validate_presence_of :account }

  it { should validate_presence_of :transaction }

  it { should validate_presence_of :name }

  it { should validate_presence_of :category }

  it { should belong_to :account }

  it { should belong_to :transaction }
end
