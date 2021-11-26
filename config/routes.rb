Rails.application.routes.draw do
  devise_for :users
  root "codes#index"

  resources :codes do
    resources :comments, only: :create
  end

  resources :users, only: [:show, :edit, :update]

  resources :histories, only: :index
end
