Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root to: "players#index"

  get "admin" => "admin#index", :as => :admin

  resource :login, only: [:new, :show, :create, :destroy]
  resource :login_request, only: [:show]

  namespace :admin do
    resources :problems, only: [:index, :create]
    resources :responses, only: [:destroy]
    resources :players, only: [:index]

    resource :relevels, only: [:update]
    put "reset_players/:id", to: "reset_players#update", as: :reset_player
  end

  resources :players
  resources :problems, only: [:show]
  resource :responses, only: [:create, :new], path: "game"
  resources :sessions, only: [:create, :destroy]
  resources :scores, only: [:show]
end
