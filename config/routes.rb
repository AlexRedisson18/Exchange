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
end

#         new_user_session GET    /users/sign_in(.:format)     -        users/sessions#new
#             user_session POST   /users/sign_in(.:format)             users/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)            users/sessions#destroy

#        new_user_password GET    /users/password/new(.:format)     -   users/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)     -  users/passwords#edit
#            user_password PATCH  /users/password(.:format)            users/passwords#update
#                          PUT    /users/password(.:format)            users/passwords#update
#                          POST   /users/password(.:format)            users/passwords#create

# cancel_user_registration GET    /users/cancel(.:format)        -      users/registrations#cancel
#    new_user_registration GET    /users/sign_up(.:format)        -     users/registrations#new
#   edit_user_registration GET    /users/edit(.:format)          -      users/registrations#edit
#        user_registration PATCH  /users(.:format)                     users/registrations#update
#                          PUT    /users(.:format)                     users/registrations#update
#                          DELETE /users(.:format)                     users/registrations#destroy
#                          POST   /users(.:format)                     users/registrations#create

#    new_user_confirmation GET    /users/confirmation/new(.:format)  -  users/confirmations#new
#        user_confirmation GET    /users/confirmation(.:format)        users/confirmations#show
#                          POST   /users/confirmation(.:format)        users/confirmations#create
