Rails.application.routes.draw do
  namespace :api, except: %i[edit new], defaults: { format: :json } do
    resources :accounts
    resources :account_groups
    resources :categories
    resources :goals
    resources :saved_searches
    resources :sorted_transactions
    resources :sorting_rules
    resources :statements, only: %i[index show create destroy]
    resources :transactions do
      collection do
        post :sort
      end
    end
    resources :payments
    resources :tags, only: [:index]
    resources :balances, only: [:index] do
      collection do
        get :projected
      end
    end

    get 'statistics/activity_per_category'
    get 'statistics/activity_per_category_type'

    get 'options' => 'options#options'
    get 'options/account_types'
    get 'options/category_types'
    get 'options/goal_periods'
    get 'options/goal_types'
    get 'options/payment_types'
    get 'options/payment_periods'
    get 'options/saved_search_review'
    get 'options/saved_search_period_from'
    get 'options/saved_search_period_to'
  end

  if Rails.env.development? || Rails.env.test?
    mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  end

  get '*page' => 'application#boot', as: :boot

  root 'application#boot'
end
