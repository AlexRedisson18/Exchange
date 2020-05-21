Rails.application.routes.draw do
  get 'welcome/home'

  devise_for :users, controllers: { sessions: 'sessions',
                                    registrations: 'registrations',
                                    confirmations: 'confirmations',
                                    passwords: 'passwords' }

  root 'welcome#home', as: 'home'

  resources :lots
end
