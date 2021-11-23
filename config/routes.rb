Rails.application.routes.draw do
  root 'events#index'
  
  devise_for :users
  
  resources :users, only: [:show, :edit, :update]
  resources :events
end
