Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  mount Sidekiq::Web => '/sidekiq'

  scope "(:region)", region: /#{I18n.available_locales.join('|')}/ do
    devise_for :users
    root 'page#home', :as => 'home'
    get 'test/output', :as => 'output'
    get '/documentation' => 'page#doc', :as => 'doc'
  end

  scope module: 'api', path: 'api' do
    resources :auth, only: [:create]
    resources :user, only: [:destroy]
    delete '/signout' => 'auth#signout'
    post '/signup' => 'user#create'
    get '/find' => 'find#find'
  end
end

