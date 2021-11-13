Rails.application.routes.draw do
  get 'statics/coming'
  devise_for :users
  resources :users, only: :index
  resources :products
  resources :bids, only: [:index, :create]
  get "bids/render_bids_row"

  # root "statics#coming"
  root "bids#index"
end
