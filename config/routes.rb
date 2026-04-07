Rails.application.routes.draw do
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"

  resources :products, only: [:create, :index]
  resources :clients, only: [:create, :index]

  post "/public/clients", to: "public_clients#create"

  resources :orders, only: [:create, :index]
end