Rails.application.routes.draw do
  resources :subscriptions
  resources :comments
  root 'events#index'
  
  devise_for :users
  
  resources :users, only: %i[ show edit update ]

  resources :events do
    resources :comments, only: %i[ create destroy ]
    resources :subscriptions, only: %i[ create destroy ]
  end
end
