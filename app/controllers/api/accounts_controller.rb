module Api
  class AccountsController < BaseController
    def index
      @accounts = Account.all

      @accounts = @accounts.order(:name)

      respond_with @accounts
    end

    def show
      @account = Account.find(account_id)

      respond_with @account
    end

    def create
      @account = Account.new(account_params)

      @account.save

      respond_with @account
    end

    def update
      @account = Account.find(account_id)

      @account.update(account_params)

      respond_with @account
    end

    def destroy
      @account = Account.find(account_id)

      @account.destroy

      respond_with @account
    end

    private

    def account_id
      params[:id].to_s
    end

    def account_params
      params.permit(:name, :number, :type, :account_group_id)
    end
  end
end
