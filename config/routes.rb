Rails.application.routes.draw do

	scope ":locale", locale:  /en|es/ do
		devise_for :users
		root to: 'agencies#index'
	  resources :agencies
		resources :users
		resources :faqs
		get 'pages/about'
	  get 'search', to: 'search#search'
    resources :categories, except: [:destroy]
    resources :websites, only: [:create, :destroy]
    resources :website_types, only: [:create, :destroy]
    get 'websites/new'
		# match '/send_mail', to: 'contact#send_mail', via: 'post'
		resources :feedback_forms
		#code added to serach with pg
		resources :search, only: [:index]
	end
#get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
get '', to: redirect("/#{I18n.default_locale}/")
end
