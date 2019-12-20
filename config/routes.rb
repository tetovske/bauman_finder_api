Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  mount Sidekiq::Web => '/sidekiq'

  scope "(:region)", region: /#{I18n.available_locales.join('|')}/ do
    get 'test/output', :as => 'output'
    root 'page#home', :as => 'home'
  end

  scope module: 'api', path: 'api', defaults: { format: :json } do
    resources :auth, only: [:create]
    post '/signup' => 'user#create'
    delete '/signout' => 'auth#signout'
    get '/find' => 'find#find'
  end
end

