require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  devise_for :users,
             :controllers => {
               :omniauth_callbacks => 'users/omniauth_callbacks',
               :registrations => 'users/registrations'
             }
  resources :users

  namespace :references do
    concern :pictureable do
      resources :pictures, only: [:index, :show, :create, :destroy]
    end
    resources :equipments
    resources :muscles, concerns: :pictureable
    resources :exercises
    resources :body_parts
  end

  resources :pictures, only: [:index, :create, :update, :destroy]

  namespace :journal do
    resources :items
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end