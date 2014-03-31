module Api
  class TransactionsController < BaseController
    def index
      @transactions = Transaction.includes(sorted_transaction: :category)

      if account_id.present?
        @transactions = @transactions.where(account_id: account_id)
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

      if filter_search_query
        @transactions = @transactions.search_query(params[:query])
      end

      if filter_with_category
        @transactions = @transactions.with_category(params[:category_id])
      end

      if filter_between_dates
        @transactions = @transactions.between_dates(params[:date_from], params[:date_to])
      end

      if filter_with_tags
        @transactions = @transactions.with_tags(params[:tag_ids])
      end

      @transactions = @transactions.order(posted_at: :desc)

      @transactions = @transactions.page(page_number)

      set_pagination_header(@transactions)

      unpaged_transactions = @transactions.limit(nil).offset(nil)

      set_metadata_header(
        total_spent: -1 * unpaged_transactions.where(['amount < 0']).sum(:amount),
        total_received: unpaged_transactions.where(['amount > 0']).sum(:amount)
      )

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

    def sort
      sorted_transactions = sort_base.select do |t|
        sorter = TransactionSorter.new(t)
        sorter.sort
        sorter.sorted_transaction.present?
      end

      respond_with message: "Sorted #{sorted_transactions.size} transactions."
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

    def filter_search_query
      params.has_key?(:query)
    end

    def filter_with_category
      params.has_key?(:category_id)
    end

    def filter_with_tags
      params.has_key?(:tag_ids)
    end

    # FIXME: Yuck.
    def filter_between_dates
      if params.has_key?(:date_from) && params.has_key?(:date_to)
        begin
          Date.parse(params[:date_from])
          Date.parse(params[:date_to])
          return true
        rescue ArgumentError
          return false
        end
      end
      false
    end

    def transaction_params
      params.permit(:amount, :fit_id, :memo, :name, :payee, :posted_at, :ref_number, :type, :account_id)
    end

    def sort_base
      if params.has_key?(:account_id)
        Account.find(params[:account_id]).transactions.unsorted
      else
        Transaction.unsorted
      end
    end
  end
end
