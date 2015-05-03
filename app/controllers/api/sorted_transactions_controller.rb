module Api
  class SortedTransactionsController < BaseController
    def index
      @sorted_transactions = SortedTransaction.all

      @sorted_transactions = @sorted_transactions.page(page_number)

      set_pagination_header(@sorted_transactions)

      respond_with @sorted_transactions
    end

    def show
      @sorted_transaction = SortedTransaction.find(sorted_transaction_id)

      respond_with @sorted_transaction
    end

    def create
      @sorted_transaction = SortedTransaction.new(sorted_transaction_params)

      @sorted_transaction.save

      respond_with @sorted_transaction
    end

    def update
      @sorted_transaction = SortedTransaction.find(sorted_transaction_id)

      @sorted_transaction.update(sorted_transaction_params)

      respond_with @sorted_transaction
    end

    def destroy
      @sorted_transaction = SortedTransaction.find(sorted_transaction_id)

      @sorted_transaction.destroy

      respond_with @sorted_transaction
    end

    private

    def sorted_transaction_id
      params[:id].to_s
    end

    def sorted_transaction_params
      params.permit(:name, :transaction_id, :account_id, :category_id, :review, :tags, :note)
    end
  end
end
