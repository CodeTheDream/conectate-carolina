Rails.application.routes.draw do

	scope ":locale", locale:  /en|es/ do
		devise_for :users
		root to: 'agencies#index'
	  resources :agencies
		resources :users
		get 'visitors/about'
	  get 'search', to: 'search#search'
    resources :categories, except: [:destroy]
    resources :websites, only: [:create, :destroy]
    get 'websites/new'
    get 'faq', :to => 'help_pages#faq'
	end
#get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
get '', to: redirect("/#{I18n.default_locale}/")
end
