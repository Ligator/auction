Rails.application.routes.draw do
  get 'statics/coming'
  devise_for :users
  resources :users, only: :index
  resources :products
  root "statics#coming"
  resources :bids, only: [:index, :create]
  # root "bids#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
