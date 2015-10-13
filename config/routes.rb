Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users,
             :controllers => {
               :omniauth_callbacks => 'users/omniauth_callbacks',
               :registrations => 'users/registrations'
             }
  resources :users
  resources :muscles
  resources :exercises
  resources :body_parts

  root 'welcome#index'
end
