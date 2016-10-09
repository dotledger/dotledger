require 'rails_helper'

describe Api::BalancesController do
  let!(:account) { FactoryGirl.create :account, balance: 1000.0 }

  describe 'GET index' do
    context 'no account id' do
      it 'returns page not found' do
        get :index

        expect(response).to be_not_found
      end
    end

    context 'with no date' do
      it 'calculates the balances for the current month' do
        expect(BalanceCalculator).to receive(:new).with(
          date_from: DateTime.now.beginning_of_month.to_date,
          date_to: DateTime.now.end_of_month.to_date,
          account: account
        )

        get :index, account_id: account.id
      end
    end

    context 'with date' do
      let(:date) { '2013-03-06' }

      it 'calculates the balances for the specified month' do
        expect(BalanceCalculator).to receive(:new).with(
          date_from: DateTime.parse(date).beginning_of_month.to_date,
          date_to: DateTime.parse(date).end_of_month.to_date,
          account: account
        )

        get :index, account_id: account.id, date: date
      end
    end

    context 'with date_from and date_to' do
      let(:date_from) { '2014-03-06' }
      let(:date_to) { '2014-03-29' }

      it 'calculates the balances for the specified date range' do
        expect(BalanceCalculator).to receive(:new).with(
          date_from: DateTime.parse(date_from).to_date,
          date_to: DateTime.parse(date_to).to_date,
          account: account
        )

        get :index, account_id: account.id, date_from: date_from, date_to: date_to
      end
    end
  end

  describe 'GET projected' do
    context 'with no date' do
      it 'calculates the balances for the current month' do
        expect(BalanceProjector).to receive(:new).with(
          date_from: DateTime.now.beginning_of_month.to_date,
          date_to: DateTime.now.end_of_month.to_date,
          opening_balance: 1000.0
        )

        get :projected
      end
    end

    context 'with date' do
      let(:date) { '2013-03-06' }

      it 'calculates the balances for the specified month' do
        expect(BalanceProjector).to receive(:new).with(
          date_from: DateTime.parse(date).beginning_of_month.to_date,
          date_to: DateTime.parse(date).end_of_month.to_date,
          opening_balance: 1000.0
        )

        get :projected, date: date
      end
    end

    context 'with date_from and date_to' do
      let(:date_from) { '2014-03-06' }
      let(:date_to) { '2014-03-29' }

      it 'calculates the balances for the specified date range' do
        expect(BalanceProjector).to receive(:new).with(
          date_from: DateTime.parse(date_from).to_date,
          date_to: DateTime.parse(date_to).to_date,
          opening_balance: 1000.0
        )

        get :projected, date_from: date_from, date_to: date_to
      end
    end
  end
end
