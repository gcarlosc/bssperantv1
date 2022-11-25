require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  resources :posts do
    post :auto_create, on: :collection
  end
  root 'posts#index'
end
