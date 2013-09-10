class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def boot
    gon.accounts = Account.order(:name)
    gon.account_types = Account::ACCOUNT_TYPES
    gon.category_types = Category::CATEGORY_TYPES
    gon.goal_periods = Goal::GOAL_PERIODS
  end
end
