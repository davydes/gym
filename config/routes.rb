require 'sidekiq/web'

Rails.application.routes.draw do
  concern :pictureable do
    resources :picture_links, only: [:index, :show, :create, :destroy], path: 'pictures'
  end

  root 'welcome#index'
  get 'welcome/index'

  devise_for :users,
             :controllers => {
               :omniauth_callbacks => 'users/omniauth_callbacks',
               :registrations => 'users/registrations'
             }
  resources :users
  resources :muscles, concerns: :pictureable
  resources :exercises
  resources :body_parts
  resources :pictures, only: [:index, :create, :update, :destroy]

  namespace :journal do
    resources :items
  end
  get :journal, to: 'journal/items#index'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
