Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :agencies
  get 'search', to: 'search#search'
end
