require 'spec_helper'

describe Goal do
  it { should have_db_column(:amount).of_type(:decimal).with_options(:null => false, :precision => 10, :scale => 2, :default => 0.0) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(:null => false) }

  it { should have_db_column(:period).of_type(:string).with_options(:null => false, :default => 'Month') }

  it { should validate_presence_of :category }
  
  it { should validate_presence_of :amount }

  it { should validate_presence_of :period }
  
  it { should ensure_inclusion_of(:period).in_array(['Month', 'Fortnight', 'Week']) }

  it { should belong_to :category }
end
