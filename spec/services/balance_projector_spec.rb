require 'rails_helper'

describe BalanceProjector do
  let(:opening_balance) { 1000.00 }

  let!(:payment1) do
    schedule = IceCube::Schedule.new(Date.parse('2014-01-01')) do |s|
      s.add_recurrence_rule(IceCube::Rule.daily(2))
    end
    FactoryBot.create :payment, type: 'Spend', amount: 10.00, schedule: schedule
  end

  let!(:payment2) do
    schedule = IceCube::Schedule.new(Date.parse('2014-01-01')) do |s|
      s.add_recurrence_rule(IceCube::Rule.daily(4))
    end
    FactoryBot.create :payment, type: 'Receive', amount: 50.00, schedule: schedule
  end

  let(:expected) do
    [
      { balance: BigDecimal.new('1040.0'), date: Date.parse('2014-01-01') },
      { balance: BigDecimal.new('1040.0'), date: Date.parse('2014-01-02') },
      { balance: BigDecimal.new('1030.0'), date: Date.parse('2014-01-03') },
      { balance: BigDecimal.new('1030.0'), date: Date.parse('2014-01-04') },
      { balance: BigDecimal.new('1070.0'), date: Date.parse('2014-01-05') },
      { balance: BigDecimal.new('1070.0'), date: Date.parse('2014-01-06') },
      { balance: BigDecimal.new('1060.0'), date: Date.parse('2014-01-07') },
      { balance: BigDecimal.new('1060.0'), date: Date.parse('2014-01-08') },
      { balance: BigDecimal.new('1100.0'), date: Date.parse('2014-01-09') },
      { balance: BigDecimal.new('1100.0'), date: Date.parse('2014-01-10') },
      { balance: BigDecimal.new('1090.0'), date: Date.parse('2014-01-11') },
      { balance: BigDecimal.new('1090.0'), date: Date.parse('2014-01-12') },
      { balance: BigDecimal.new('1130.0'), date: Date.parse('2014-01-13') },
      { balance: BigDecimal.new('1130.0'), date: Date.parse('2014-01-14') },
      { balance: BigDecimal.new('1120.0'), date: Date.parse('2014-01-15') },
      { balance: BigDecimal.new('1120.0'), date: Date.parse('2014-01-16') },
      { balance: BigDecimal.new('1160.0'), date: Date.parse('2014-01-17') },
      { balance: BigDecimal.new('1160.0'), date: Date.parse('2014-01-18') },
      { balance: BigDecimal.new('1150.0'), date: Date.parse('2014-01-19') },
      { balance: BigDecimal.new('1150.0'), date: Date.parse('2014-01-20') }
    ]
  end

  subject do
    described_class.new(
      opening_balance: opening_balance,
      date_from: Date.parse('2014-01-01'),
      date_to: Date.parse('2014-01-20')
    )
  end

  specify do
    expect(subject.as_json).to eq(expected)
  end
end
