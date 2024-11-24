Rails.application.routes.draw do
  root "home#index"

  devise_for :customers
  # Customer routes
  resources :customers, only: [:index, :show, :edit, :update, :destroy]
  # Nest builds under customers for better organization
  resources :builds, only: [:index, :new, :create, :edit, :update, :destroy] # For "My Builds" and "Create a Build"

end
