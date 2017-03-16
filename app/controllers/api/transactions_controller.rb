module Api
  class TransactionsController < BaseController
    def index
      @transactions = Transaction.includes(sorted_transaction: :category)

      @transactions = @transactions.where(account_id: account_id) if account_id.present?

      @transactions = @transactions.sorted if filter_sorted

      @transactions = @transactions.unsorted if filter_unsorted

      @transactions = @transactions.for_review if filter_for_review

      @transactions = @transactions.not_for_review if filter_not_for_review

      @transactions = @transactions.search_query(params[:query]) if filter_search_query

      @transactions = @transactions.with_category(params[:category_id]) if filter_with_category

      @transactions = @transactions.with_category_type(params[:category_type]) if filter_with_category_type

      @transactions = @transactions.between_dates(params[:date_from], params[:date_to]) if filter_between_dates

      @transactions = @transactions.with_tags(params[:tag_ids]) if filter_with_tags

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
      params[:sorted].to_s =~ /true/i
    end

    def filter_unsorted
      params[:unsorted].to_s =~ /true/i
    end

    def filter_for_review
      params[:review].to_s =~ /true/i
    end

    def filter_not_for_review
      params[:review].to_s =~ /false/i
    end

    def filter_search_query
      params.key?(:query)
    end

    def filter_with_category
      params.key?(:category_id)
    end

    def filter_with_tags
      params.key?(:tag_ids)
    end

    def filter_with_category_type
      params.key?(:category_type)
    end

    # FIXME: Yuck.
    def filter_between_dates
      if params.key?(:date_from) && params.key?(:date_to)
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
      if params.key?(:account_id)
        Account.find(params[:account_id]).transactions.unsorted
      else
        Transaction.unsorted
      end
    end
  end
end
