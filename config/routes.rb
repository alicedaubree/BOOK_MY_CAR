Rails.application.routes.draw do
  devise_for :users
  root to: "car#home"
  get "profile", to: "pages#profil"
  resources :car do
    resources :booking
    # , only: [ :create,:destroy ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
