# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'

  get '/register', to: 'users#new'

  resources :users, only: %i[create show] do
    member do
      get 'discover', to: 'users/discover#index'
      get 'movies', to: 'users/movies#index'
    end
  end
end
