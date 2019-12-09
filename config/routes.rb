Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  mount Sidekiq::Web => '/sidekiq'

  root 'test#input', :as => 'input'
  get 'test/output', :as => 'output'
end
