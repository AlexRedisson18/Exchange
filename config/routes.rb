Rails.application.routes.draw do
  get 'welcome/home'
  devise_for :users, controllers: {
          sessions: 'users/sessions'
  }

  root 'welcome#home', as: 'home'

  resources :lots
end
