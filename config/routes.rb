Rails.application.routes.draw do

  root "static_pages#home"
  resources :categories, only: %i(index show) do
    resources :lessons, only: %i(create)
  end
  resources :lessons, only: %i(show update)
  resources :words, only: %i(index)
  devise_for :users
  resources :users, only: %i(show index) do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create destroy)
  namespace :admin do
    root "categories#index"
    resources :categories
    resources :words
    resources :users
  end
end

