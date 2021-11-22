Rails.application.routes.draw do
  devise_for :users
  root "codes#index"

  resources :codes
end
