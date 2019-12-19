Rails.application.routes.draw do
  devise_for :users
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  mount Sidekiq::Web => '/sidekiq'

  root 'page#home', :as => 'home'
  get 'test/output', :as => 'output'

  # resources :auth, only: [:create, :destroy, :login]
  # resources :user, only: [:create, :destroy, :update]

  get 'auth' => 'auth#create', :as => 'authorize_user'
  post 'users/create' => 'user#create', :as => 'user_create'
end
