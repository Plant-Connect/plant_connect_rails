require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => "/cable"

  namespace :api do
    namespace :v1 do
      resources :listings, only: [:index, :create]
      patch '/listings', to: 'listings#update'
      resources :messages, only: [:create]
      resources :conversations, only: [:index]
    end
  end
end
