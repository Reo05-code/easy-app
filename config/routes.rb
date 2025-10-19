Rails.application.routes.draw do
  root "posts#index"
  get "users/index"
  get "users/show"
  devise_for :users
  resources :posts
  resources :users, only: [:index, :show]



  get "up" => "rails/health#show", as: :rails_health_check
end
