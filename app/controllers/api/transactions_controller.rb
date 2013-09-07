module Api
  class TransactionsController < BaseController
    def index
      @transactions = Transaction.includes(:sorted_transaction => :category)

      if account_id.present?
        @transactions = @transactions.where(:account_id => account_id)
      end

      if filter_sorted
        @transactions = @transactions.sorted
      end

      if filter_unsorted
        @transactions = @transactions.unsorted
      end

      if filter_for_review
        @transactions = @transactions.for_review
      end

      if filter_not_for_review
        @transactions = @transactions.not_for_review
      end

      @transactions = @transactions.order(:posted_at => :desc)

      @transactions = @transactions.page(page_number)

      set_pagination_header(@transactions)

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

    def filter_sorted
      !!(params[:sorted].to_s =~ /true/i)
    end

    def filter_unsorted
      !!(params[:unsorted].to_s =~ /true/i)
    end

    def filter_for_review
      !!(params[:review].to_s =~ /true/i)
    end

    def filter_not_for_review
      !!(params[:review].to_s =~ /false/i)
    end

    def transaction_params
      params.permit(:amount, :fit_id, :memo, :name, :payee, :posted_at, :ref_number, :type, :account_id)
    end
  end
end
