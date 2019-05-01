Rails.application.routes.draw do
	namespace :api do
        namespace :v1 do
            resources :faqs
        end
        
		namespace :v1 do
	    	resources :categories, only: [:index]
    	end
    end

	scope ":locale", locale:  /en|es/ do
		devise_for :users
		root to: 'agencies#index'
	  resources :agencies do
	  	collection { post :import }
	  end
		resources :users
		resources :faqs
		get 'pages/about'
	  get 'search', to: 'search#search'
    resources :categories
    resources :websites, only: [:new, :create, :show, :destroy]
    resources :website_types, only: [:new, :create, :show, :destroy]
    get 'websites/new'
		# match '/send_mail', to: 'contact#send_mail', via: 'post'
		resources :feedback_forms
		#code added to serach with pg
		resources :search, only: [:index]
	end
#get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
get '', to: redirect("/#{I18n.default_locale}/")
end
