Rails.application.routes.draw do
  concern :pictureable do
    resources :pictures, only: [:index, :destroy], shallow: true
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
end
