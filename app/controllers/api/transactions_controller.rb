module Api
  class TransactionsController < BaseController
    def index
      @transactions = Transaction.all

      if account_id.present?
        @transactions = @transactions.where(:account_id => account_id)
      end

      respond_with @transactions
    end

    def show
      @transaction = Transaction.find(transaction_id)

      respond_with @transaction
    end

    def create
      @transaction = Transaction.new(transaction_params)

      @transaction.save

      respond_with @transaction
    end

    def update
      @transaction = Transaction.find(transaction_id)

      @transaction.update(transaction_params)

      respond_with @transaction
    end

    def destroy
      @transaction = Transaction.find(transaction_id)

      @transaction.destroy

      respond_with @transaction
    end

    private

    def transaction_id
      params[:id].to_s
    end

    def account_id
      params[:account_id].to_s
    end

    def transaction_params
      params.permit(:amount, :fit_id, :memo, :name, :payee, :posted_at, :ref_number, :type, :account_id)
    end
  end
end
