Rails.application.routes.draw do
  devise_for :users
  # Root
  root to: 'welcome#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # UsersController
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  resources :users, only: :show
  resources :friendships, only: :destroy
  # StockController
  get 'search_stocks', to: 'stocks#search'
  # UserStockController
  resources :user_stocks, only: %i[create destroy]
end
