module Api
  class BalancesController < BaseController
    include DateRangeParams

    def index
      begin
        account = Account.find(params[:account_id])
        @balances = BalanceCalculator.new(
          date_from: date_range.first,
          date_to: date_range.last,
          account: account
        )

        respond_with @balances
      rescue ActiveRecord::RecordNotFound
        respond_with [], status: :not_found
      end
    end
  end
end
