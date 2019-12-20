Rails.application.routes.draw do
  resources :users
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  mount Sidekiq::Web => '/sidekiq'

  scope "(:region)", region: /#{I18n.available_locales.join('|')}/ do
    get 'test/output', :as => 'output'

    get 'sigin' => 'auth#auth', :as => 'signin'
    get 'auth' => 'auth#authorize_user', :as => 'auth'
    get 'sigoun' => 'auth#sign_out', :as => 'sign_out'

    root 'page#home', :as => 'home'

    resources :users
  end
end
