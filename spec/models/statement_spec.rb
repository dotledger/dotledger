require 'rails_helper'

describe Statement do
  it { should have_db_column(:balance).of_type(:decimal).with_options(null: false, precision: 10, scale: 2) }

  it { should have_db_column(:account_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:from_date).of_type(:date) }

  it { should have_db_column(:to_date).of_type(:date) }

  it { should validate_presence_of :balance }

  it { should validate_presence_of :account }

  it { should belong_to :account }

  it { should have_many :transactions }
end
