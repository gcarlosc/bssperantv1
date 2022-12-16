require 'sidekiq/web'
Rails.application.routes.draw do
  resources :rooms
  mount Sidekiq::Web, at: '/sidekiq'

  root 'posts#index'

  resources :posts do
    post :auto_create, on: :collection
  end

  resources :rooms do
    resources :messages
  end
end
