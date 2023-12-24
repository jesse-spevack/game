Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Marketing
  # Defines the root path route ("/")
  root to: "home#index"
  get "alpha_announcement" => "home#alpha_announcement", :as => :alpha_announcement
  get "learn-more" => "home#learn_more", :as => :learn_more

  # Authentication
  resource :login, only: [:new, :show, :create, :destroy]
  resource :login_request, only: [:show]
  # Temporary backdoor login for Stripe
  get "stripe-login" => "backdoor_logins#create", :as => :backdoor_login

  # Invites
  resources :invites, only: [:new, :create, :destroy]
  resource :accept_invite, only: [:show]

  # Admin
  get "admin" => "admin#index", :as => :admin

  namespace :admin do
    resources :problems, only: [:index, :create]
    resources :players, only: [:index]

    resource :relevels, only: [:update]
    post "reset_players/:id", to: "reset_players#update", as: :reset_player

    resources :teams, only: [:edit, :update, :show, :destroy]
  end

  # Game
  resources :players
  resources :problems, only: [:show]
  resource :responses, only: [:create, :new], path: "game"
  resources :sessions, only: [:create, :destroy]
  resources :scores, only: [:show]

  # Settings
  resource :team, only: [:show, :edit, :update]

  # Stripe
  resources :orders, only: [:new]
  get "success" => "checkout_successes#show"
  post "webhook" => "webhooks#create"
end
