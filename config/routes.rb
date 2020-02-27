Rails.application.routes.draw do
  resources :user
  resources :tables
  resources :meals
  devise_for :users
  root to: 'tables#index'
  get '/search' , to: 'meals#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
