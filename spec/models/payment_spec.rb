require 'rails_helper'

describe Payment do
  before { FactoryGirl.create :payment }

  it { should have_db_column(:name).of_type(:string).with_options(null: false) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:amount).of_type(:decimal).with_options(null: false, precision: 10, scale: 2) }

  it { should have_db_column(:type).of_type(:string).with_options(null: false, default: 'Spend') }

  it { should have_db_column(:schedule).of_type(:text).with_options(null: false) }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }

  it { should validate_presence_of :category }

  it { should validate_presence_of :amount }

  it { should validate_presence_of :schedule }

  it { should validate_presence_of :type }

  it { should validate_inclusion_of(:type).in_array(%w(Spend Receive)) }

  it { should serialize(:schedule).as_instance_of(ScheduleSerializer) }
end
