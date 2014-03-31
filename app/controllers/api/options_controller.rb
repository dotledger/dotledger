module Api
  class OptionsController < BaseController
    def options
      respond_with(
        account_types: Account::ACCOUNT_TYPES,
        category_types: Category::CATEGORY_TYPES,
        goal_periods: Goal::GOAL_PERIODS,
        payment_types: Payment::PAYMENT_TYPES,
        payment_periods: Payment::PAYMENT_PERIODS
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

    def payment_types
      respond_with payment_types: Payment::PAYMENT_TYPES
    end

    def payment_periods
      respond_with payment_periods: Payment::PAYMENT_PERIODS
    end
  end
end
