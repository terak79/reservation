Rails.application.routes.draw do
  get "reservations/index"
  get "reservations/new"
  get "reservations/create"
  get "rooms/index"
  get "rooms/show"
  get "rooms/new"
  get "rooms/create"
  devise_for :users

  root "rooms#index"

  resources :rooms do
    resources :reservations, only: [ :new, :create ]
  end

  resources :reservations, only: [ :index ]

  namespace :users do
    get "profiles/show"
    get "profiles/edit"
    get "profiles/update"
    resource :profile, only: [ :show, :edit, :update ]
  end
end
