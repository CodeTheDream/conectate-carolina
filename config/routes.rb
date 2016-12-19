Rails.application.routes.draw do
  get 'websites/new'

	scope ":locale", locale:  /en|es/ do
		root to: 'agencies#index'
	  devise_for :users
	  resources :agencies
	  get 'search', to: 'search#search'
    resources :categories, except: [:destroy]
    resources :websites
	end
#get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
get '', to: redirect("/#{I18n.default_locale}/")
end
