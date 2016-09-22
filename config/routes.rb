Rails.application.routes.draw do
  root to: 'visitors#index'
  resources :agencies
  devise_for :users
end
