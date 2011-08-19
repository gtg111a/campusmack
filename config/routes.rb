Campusmack::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :votes, :only =>[:destroy]
  #get "sessions/new"
  resources :support, :only => [:new, :create]
  resources :comments
  resources :posts do
    resources :comments, :only => [:create, :destroy, :edit]
    member do
      post :vote_up, :vote_down
    end
  end
  resources :users do
    resources :colleges, :only => [:show] do
      resources :posts
    end
    member do
      get :following, :followers
    end
  end
  #resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :colleges, :only => [:new, :create, :show] do
    resources :smacks, :redemptions, :posts, :only => [:show, :index, :destroy] do
      member do
        post :vote_up, :vote_down
      end
    end
  end

  match '/search', :to => 'posts#index'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'

  root :to => 'pages#home'
end

