Rails.application.routes.draw do
  root to: 'agencies#index'
  devise_for :users
  resources :agencies
  get 'search', to: 'search#search'
end
