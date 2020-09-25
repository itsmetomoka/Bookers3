Rails.application.routes.draw do
	root 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  resources :users, only: [:show, :edit, :update, :create, :index] do
  	resource :relationships, only: [:create, :destroy]
  	get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  resources :books, only: [:new, :create, :index, :show, :destroy,:edit,:update] do
  	resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
