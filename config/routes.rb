Rails.application.routes.draw do
  root to: 'agencies#index'
  resources :agencies
  devise_for :users
  resources :agencies
  get 'search', to: 'search#search'
end
