Campusmack::Application.routes.draw do
  devise_for :users, :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => 'users/registrations',
      :confirmations => 'users/confirmations',
      :sessions => 'users/sessions'
  }, :skip => [:sessions] do
    get 'sign_up' => 'users/registrations#new', :as => :sign_up
    get 'sign_in' => 'users/sessions#new', :as => :sign_in
    post 'sign_in' => 'users/sessions#create', :as => :new_user_session
    get 'sign_out' => 'users/sessions#destroy', :as => :sign_out
  end

  resources :votes, :only =>[:destroy]
  #get "sessions/new"
  resources :support, :only => [:new, :create]
  resources :comments
  resources :smacks, :redemptions, :posts do
    resources :comments, :only => [:create, :destroy, :edit]
    member do
      post :vote_up, :vote_down
    end
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :colleges, :only => [:show] do
    resources :posts
  end

  resources :posts do
    member do
      get :report
    end
  end

  get '/reports', :to => 'reports#index'

  resources :colleges do
    resources :videos, :only => :index, :controller => 'posts', :defaults => { :content_type => 'video' }
    resources :photos, :only => :index, :controller => 'posts', :defaults => { :content_type => 'photo' }
    resources :news, :only => :index, :controller => 'posts', :defaults => { :content_type => 'news' }
    resources :stats, :only => :index, :controller => 'posts', :defaults => { :content_type => 'stat' }
  end
  #resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :colleges, :only => [:new, :create, :show] do
    resources :smacks, :redemptions do
      collection { get :videos, :defaults => { :content_type => 'video' }, :action => 'index'  }
      collection { get :photos, :defaults => { :content_type => 'photo' }, :action => 'index' }
      collection { get :news, :defaults => { :content_type => 'news' }, :action => 'index'  }
      collection { get :stats, :defaults => { :content_type => 'stat' }, :action => 'index'  }
    end
    resources :smacks, :redemptions, :posts, :only => [:show, :index, :destroy] do
      member do
        post :vote_up, :vote_down
      end
    end
  end
  resources :authentications, :only => [:index, :destroy]

  match '/search', :to => 'posts#index'
  get '/contact-us', :to => 'support#new'
  post '/contact-us', :to => 'support#create'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'

  root :to => 'welcome#index'
end

