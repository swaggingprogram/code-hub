Rails.application.routes.draw do
  devise_for :users
  root "codes#index"

  resources :codes do
    resources :comments, only: :create
    collection do
      get 'search'
      get 'about'
      get 'employ'
    end
    resources :histories, only: :index
  end

  resources :users, only: [:show, :edit, :update]
end
