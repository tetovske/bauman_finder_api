Rails.application.routes.draw do
  get 'admin/admin'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, only: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  scope "(:region)", region: /#{I18n.available_locales.join('|')}/ do
    root 'page#home', :as => 'home'
    devise_for :users, skip: :omniauth_callbacks, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    get 'test/output', :as => 'output'
    get '/documentation' => 'page#doc', :as => 'doc'
    get '/account' => 'page#account', :as => 'account'
    get '/regenerate' => 'page#regenerate_token', :as => 'regenerate_token'
  end

  scope module: 'api', defaults: { format: 'json' }  do
    scope module: 'v1', path: 'v1' do
      get '/:search_meth' => 'api_request#handle_request', :as => 'v1_handler'
    end

    scope module: 'v2', path: 'v2' do
      resources :auth, only: [:create]
      resources :user, only: [:destroy]
      delete '/signout' => 'auth#signout'
      post '/signup' => 'user#create'
      get '/find' => 'find#find'
    end
  end
end

