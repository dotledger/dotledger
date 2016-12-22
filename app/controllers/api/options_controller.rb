module Api
  class OptionsController < BaseController
    def options
      respond_with(
        account_types: Account::ACCOUNT_TYPES,
        category_types: Category::CATEGORY_TYPES,
        goal_periods: Goal::GOAL_PERIODS,
        goal_types: Goal::GOAL_TYPES,
        payment_types: Payment::PAYMENT_TYPES,
        payment_periods: Payment::PAYMENT_PERIODS,
        saved_search_review: SavedSearch::REVIEW,
        saved_search_period_from: SavedSearch::PERIOD_FROM,
        saved_search_period_to: SavedSearch::PERIOD_TO
      )
    end

    def account_types
      respond_with account_types: Account::ACCOUNT_TYPES
    end

    def category_types
      respond_with category_types: Category::CATEGORY_TYPES
    end

    def goal_periods
      respond_with goal_periods: Goal::GOAL_PERIODS
    end

    def goal_types
      respond_with goal_types: Goal::GOAL_TYPES
    end

    def payment_types
      respond_with payment_types: Payment::PAYMENT_TYPES
    end

    def payment_periods
      respond_with payment_periods: Payment::PAYMENT_PERIODS
    end

    def saved_search_review
      respond_with saved_search_review: SavedSearch::REVIEW
    end

    def saved_search_period_from
      respond_with saved_search_period_from: SavedSearch::PERIOD_FROM
    end

    def saved_search_period_to
      respond_with saved_search_period_to: SavedSearch::PERIOD_TO
    end
  end
end
