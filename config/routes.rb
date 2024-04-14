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
  get "privacy-policy" => "home#privacy_policy", :as => :privacy_policy
  get "tos" => "home#tos", :as => :tos

  # Authentication
  resource :login, only: [:new, :show, :create, :destroy]
  resource :login_request, only: [:show]
  resource :one_time_password, only: [:new]
  resource :temporary_code_login, only: [:new, :create]

  # Invites
  resources :invites, only: [:new, :create, :destroy]
  resource :accept_invite, only: [:show]

  # Admin
  get "admin" => "admin#index", :as => :admin
  namespace :admin do
    resources :users
    resources :players
    resources :teams
    resources :invoices
    resources :orders
    resources :problems
    resources :impersonations, only: [:create, :destroy]
  end

  # Game
  resources :players
  resources :problems, only: [:show]
  resource :responses, only: [:create, :new], path: "game"
  resources :sessions, only: [:create, :destroy]
  resources :scores, only: [:show]
  resources :users, only: [:destroy]
  resources :trial_memberships, only: [:create]

  # Settings
  resource :team, only: [:show, :edit, :update]
  get "settings" => "settings#index", :as => :settings
  get "settings/edit" => "settings#edit", :as => :edit_settings
  patch "settings" => "settings#update"

  # Stripe
  resources :orders, only: [:new]
  get "success" => "checkout_successes#show"
  post "webhook" => "webhooks#create"
end
