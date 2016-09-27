Rails.application.routes.draw do
  root to: 'agencies#index'
  resources :agencies
  devise_for :users
end
