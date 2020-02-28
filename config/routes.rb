Rails.application.routes.draw do

  resources :tables
  resources :meals
  devise_for :users, :path_prefix => 'my'
  resources :users do
    member do
      get :admin
      get :manager
      get :usual
    end
  end
  root to: 'tables#index'
  get '/search' , to: 'meals#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
