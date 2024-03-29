Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :faqs,       only: [:index]
			resources :categories, only: [:index]
			resources :agencies,   only: [:index]
			resources :devices,    only: [:create, :update]
			resources :messages,   only: [:index]
			resources :counties,   only: [:index]
			post '/messages/open', to: 'messages#create'
		end
	end

	scope ":locale", locale:  /en|es/ do
		devise_for :users, :skip => [:registrations]
		as :user do
		  get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
		  put 'users' => 'devise/registrations#update', as: 'user_registration'
		end
		root to: 'agencies#index'
		resources :agencies do
			collection { post :import }
			resources :agency_update_requests, only: [:new, :create]
		end
		resources :agency_update_requests, only: [:index, :edit, :update]
		resources :users
		resources :faqs
		get 'about', to: 'pages#about'
		get 'pages/privacy_policy'
		get 'pages/terms_and_conditions'
		get 'mobile', to: 'pages#mobile_page'
		get 'confirmation', to: 'pages#confirmation'
	  	get 'search', to: 'search#search'
		resources :categories
		resources :messages do
				member do
				put 'post', 'unpost'
			end
		end
    	resources :user_messages, only: [:index, :show]

		get 'inactive_messages', to: 'messages#inactive_messages', as: 'inactive_messages'
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
