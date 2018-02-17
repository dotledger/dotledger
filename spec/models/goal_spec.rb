require 'rails_helper'

describe Goal do
  it { should have_db_column(:amount).of_type(:decimal).with_options(null: false, precision: 10, scale: 2, default: 0.0) }

  it { should have_db_column(:category_id).of_type(:integer).with_options(null: false) }

  it { should have_db_column(:period).of_type(:string).with_options(null: false, default: 'Month') }

  it { should have_db_column(:type).of_type(:string).with_options(null: false, default: 'Spend') }

  it { should validate_presence_of :category }

  it { should validate_presence_of :amount }

  it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0.0) }

  it { should validate_presence_of :period }

  it { should validate_inclusion_of(:period).in_array(%w[Month Fortnight Week]) }

  it { should validate_presence_of :type }

  it { should validate_inclusion_of(:type).in_array(%w[Spend Receive]) }

  it { should belong_to :category }

  describe '.month_amount' do
    context 'month period' do
      let(:goal) { FactoryBot.create :goal, amount: 1000.00, period: 'Month' }

      specify { expect(goal.month_amount).to be_within(0.1).of(1000.00) }
    end

    context 'fortnight period' do
      let(:goal) { FactoryBot.create :goal, amount: 1000.00, period: 'Fortnight' }

      specify { expect(goal.month_amount).to be_within(0.1).of(2166.67) }
    end

    context 'week period' do
      let(:goal) { FactoryBot.create :goal, amount: 1000.00, period: 'Week' }

      specify { expect(goal.month_amount).to be_within(0.1).of(4333.33) }
    end
  end
end
