Rails.application.routes.draw do
  root "home#index"

  resources :items, only: [:new, :create, :edit, :update, :destroy, :index, :show]

  # Devise routes for admins
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admins/sessions'
  }

  # Example admin dashboard route
  get 'admin/dashboard', to: 'admins#dashboard', as: :admin_dashboard

  # Devise routes for customers
  devise_for :customers

  # Customer routes
  resources :customers, only: [:index, :show, :edit, :update, :destroy] do
    namespace :admins do
      resources :builds, only: [:index, :new, :create], as: 'builds'
    end
  end

  # Standalone builds routes for customers
  resources :builds, only: [:index, :new, :create, :edit, :update, :destroy]
end


