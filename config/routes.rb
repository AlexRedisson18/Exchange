Rails.application.routes.draw do
  root 'lots#index'

  resources :lots
end
