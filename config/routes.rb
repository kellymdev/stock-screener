Rails.application.routes.draw do
  root 'stock_exchanges#index'

  resources :stock_exchanges, only: [:index]
end
