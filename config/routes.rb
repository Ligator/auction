Rails.application.routes.draw do
  get 'statics/coming'
  devise_for :users
  resources :users, only: :index
  resources :products
  root "statics#coming"
  resources :bids, only: [:index, :create]
  # root "bids#index"
end
