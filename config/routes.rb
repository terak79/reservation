Rails.application.routes.draw do
  devise_for :users

  root "rooms#index"

  resources :rooms do
    resources :reservations, only: [ :new, :create ]
    collection do
      get :my_rooms
    end
  end

  resources :reservations, only: [ :index,  :edit, :update, :destroy ]

  namespace :users do
    resource :profile, only: [ :show, :edit, :update ]
  end
end
