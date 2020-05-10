Rails.application.routes.draw do
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
    get '/quick_search' => 'page#quick_search', :as => 'quick_search'

    scope 'admin' do
      get '/' => 'admin#admin', :as => 'admin'
      delete '/destroy_user/:id' => 'admin#destroy_user', :as => 'admin_destroy_user'
      post '/change_permissions/:id' => 'admin#change_permissions', :as => 'change_permissions_for'
    end
  end

  scope module: 'api', defaults: { format: 'json' }  do
    scope module: 'v1', path: 'v1' do
      get '/:search_meth' => 'api_request#handle_request', :as => 'v1_handler'
    end

    scope module: 'v2', path: 'v2' do
      resources :auth, only: [:create]
      delete '/signout' => 'auth#signout'
      get '/find' => 'find#find'
    end
  end
end

