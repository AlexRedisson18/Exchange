Rails.application.routes.draw do

  devise_for :users, skip: :all, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    post '/users/sign_in', to: 'users/sessions#create', as: :user_session
    delete '/users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session

    patch '/users/password', to: 'users/passwords#update', as: nil
    put '/users/password', to: 'users/passwords#update', as: nil
    post '/users/password', to: 'users/passwords#create', as: :user_password

    patch '/users', to: 'users/registrations#update', as: 'user_registration'
    put '/users', to: 'users/registrations#update', as: nil
    delete '/users', to: 'users/registrations#destroy', as: nil
    post '/users', to: 'users/registrations#create', as: nil

    get 'users/confirmation/new', to: 'users/confirmations#new', as: :new_user_confirmation
    get '/users/confirmation', to: 'users/confirmations#show', as: nil
    post '/users/confirmation', to: 'users/confirmations#create', as: 'user_confirmation'
  end

  root 'lots#index', as: 'home'

  resources :lots
  resource :profile, only: [:show]
end
