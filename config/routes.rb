Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  root to: 'home#index'

  get '/users', to: 'users#index'
  get '/users/edit_role', to: 'users#edit_role'
  put '/users/update_role', to: 'users#update_role'
  
  get '/logs', to: 'logs#index'
  resources :klasses, only: [:index, :new, :create] do
    member do
      get '/sections', to: 'klasses#section_list'
      post '/sections', to: 'klasses#section_create'
      put '/sections/:section_id/up', to: 'klasses#up', as: 'goup'
      put '/sections/:section_id/down', to: 'klasses#down', as: 'godown'
    end
  end

  resources :registrations, only: [:index, :new, :create] do
    member do
      put '/toggle_open', to: 'registrations#toggle_open'
    end
  end
end
