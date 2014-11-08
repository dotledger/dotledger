require 'rails_helper'

describe BalanceCalculator do
  let(:account) { FactoryGirl.create(:account, balance: 100.0) }

  let!(:transaction_1) do
    FactoryGirl.create(:transaction, account: account, amount: 10.0, posted_at: Date.parse('2014-03-20'))
  end

  let!(:transaction_2) do
    FactoryGirl.create(:transaction, account: account, amount: 5.0, posted_at: Date.parse('2014-03-18'))
  end

  let!(:transaction_3) do
    FactoryGirl.create(:transaction, account: account, amount: -8.99, posted_at: Date.parse('2014-03-16'))
  end

  let!(:transaction_4) do
    FactoryGirl.create(:transaction, account: account, amount: 2.0, posted_at: Date.parse('2014-03-14'))
  end

  context 'to the present balance' do
    subject do
      BalanceCalculator.new(
        account: account,
        date_from: Date.parse('2014-03-13'),
        date_to: Date.parse('2014-03-22')
      )
    end

    describe '.balances' do
      it 'returns the correct number of balances' do
        expect(subject.balances.length).to eq 10
      end

      it 'returns the closing balance for the last balance' do
        expect(subject.balances.last.balance).to eq subject.closing_balance
      end

      it 'returns the correct balances' do
        expect(subject.balances.map(&:balance).map(&:to_f)).to eq [91.99, 91.99, 93.99, 93.99, 85.0, 85.0, 90.0, 90.0, 100.0, 100.0]
      end
    end

    describe '.closing_balance' do
      it 'returns the correct closing balance' do
        expect(subject.closing_balance).to eq 100.0
      end
    end
  end

  context 'historical' do
    subject do
      BalanceCalculator.new(
        account: account,
        date_from: Date.parse('2014-03-10'),
        date_to: Date.parse('2014-03-17')
      )
    end

    describe '.balances' do
      it 'returns the correct number of balances' do
        expect(subject.balances.length).to eq 8
      end

      it 'returns the closing balance for the last balance' do
        expect(subject.balances.last.balance).to eq subject.closing_balance
      end

      it 'returns the correct balances' do
        expect(subject.balances.map(&:balance).map(&:to_f)).to eq [91.99, 91.99, 91.99, 91.99, 91.99, 93.99, 93.99, 85.0]
      end
    end

    describe '.closing_balance' do
      it 'returns the correct closing balance' do
        expect(subject.closing_balance).to eq 85.0
      end
    end
  end
end
