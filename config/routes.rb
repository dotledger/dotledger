Rahani::Application.routes.draw do
  namespace :api, :except => [:edit, :new], :defaults => {:format => :json} do
    resources :accounts
    resources :categories
    resources :sorted_transactions
    resources :sorting_rules
    resources :statements, :only => [:index, :show, :create, :destroy]
    resources :transactions
  end

  if Rails.env.development? || Rails.env.test?
    mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  end

  get "*page" => "application#boot", :as => :boot

  root 'application#boot'
end
