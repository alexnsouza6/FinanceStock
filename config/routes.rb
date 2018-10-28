Rails.application.routes.draw do
  devise_for :users
  # Root
  root to: 'welcome#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # UsersController
  get 'my_portfolio', to: 'users#my_portfolio'
  # StockController
  get 'search_stocks', to: 'stocks#search'
  # UserStockController
  resources :user_stocks, only: [:create]
end
