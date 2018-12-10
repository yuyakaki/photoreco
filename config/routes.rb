Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'rankings/like', to: 'rankings#like'
  
  get 'search', to: 'posts#search' 
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :posts, only: [:new, :create, :show, :destroy]
  resources :comments, only: [:create]
  resources :relationships, only: [:create, :destroy]
  resources :likes

end
