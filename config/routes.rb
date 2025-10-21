Rails.application.routes.draw do
  get "topics/new"
  get "topics/edit"
  root "posts#index"
  get "users/index"
  get "users/show"
  devise_for :users
  resources :posts
  resources :users, only: [:index, :show]
  resources :topics, only: [:index, :show, :new, :create, :edit, :update]



  get "up" => "rails/health#show", as: :rails_health_check
end
