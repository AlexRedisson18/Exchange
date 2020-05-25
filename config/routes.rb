Rails.application.routes.draw do
  get 'welcome/home'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  root 'welcome#home', as: 'home'

  resources :lots
end
