Rails.application.routes.draw do
	root   'static_pages#home'
	get 'sessions/new'
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	resources :users
	resources :posts, :only => [:index, :new, :create]
end
