module Api
  class BalancesController < BaseController
    include DateRangeParams

    def index
      account = Account.find(params[:account_id])

      set_metadata_header(
        date_from: date_range.first,
        date_to: date_range.last
      )

      @balances = BalanceCalculator.new(
        date_from: date_range.first,
        date_to: date_range.last,
        account: account
      )

      respond_with @balances
    rescue ActiveRecord::RecordNotFound
      respond_with [], status: :not_found
    end

    def projected
      set_metadata_header(
        date_from: date_range.first,
        date_to: date_range.last
      )

      @balances = BalanceProjector.new(
        date_from: date_range.first,
        date_to: date_range.last,
        opening_balance: Account.all.reduce(0.0) {|balance, account| account.balance + balance }
      )

      respond_with @balances
    end
  end
end
