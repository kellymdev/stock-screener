Rails.application.routes.draw do
  root 'stock_exchanges#index'

  resources :stock_exchanges, only: [:index, :show], shallow: true do
    resources :stocks, only: [:new, :create, :show, :edit, :update] do
      resources :share_prices, only: [:new, :create, :edit, :update, :destroy]
      resources :dividends, only: [:new, :create, :edit, :update, :destroy]
      resources :earnings, only: [:new, :create, :edit, :update, :destroy]
      resources :shareholders_equities, only: [:new, :create, :edit, :update, :destroy]
      get :new_report, to: 'stocks#new_report'
      post :report, to: 'stocks#report'
    end
  end
end
