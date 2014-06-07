module Api
  class BalancesController < BaseController
    def index
      account = Account.find(params[:account_id])
      @balances = BalanceCalculator.new(number_of_days: 90, account: account)

      respond_with @balances
    end
  end
end
