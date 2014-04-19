DotLedger::Application.routes.draw do
  namespace :api, except: [:edit, :new], defaults: { format: :json } do
    resources :accounts
    resources :categories
    resources :goals
    resources :sorted_transactions
    resources :sorting_rules
    resources :statements, only: [:index, :show, :create, :destroy]
    resources :transactions do
      collection do
        post :sort
      end
    end
    resources :payments
    resources :tags, only: [:index]

    get 'statistics/activity_per_category'

    get 'options' => 'options#options'
    get 'options/account_types'
    get 'options/category_types'
    get 'options/goal_periods'
    get 'options/payment_types'
    get 'options/payment_periods'
  end

  if Rails.env.development? || Rails.env.test?
    mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  end

  get "*page" => "application#boot", as: :boot

  root 'application#boot'
end
