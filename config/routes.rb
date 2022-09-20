Rails.application.routes.draw do
  devise_for :users
  root to: "cars#index"
  get "profile", to: "pages#profile"
  resources :cars do
    resources :bookings
    # , only: [ :create,:destroy ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
