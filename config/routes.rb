Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "pages#home"

  get "pages/home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Route for books index and show
  resources :books, only: [ :index, :show ] do
    resources :reviews, only: [ :create, :update, :destroy ]
  end
end
