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

  resources :users do
    member do
      match :search, :action => :show
    end
    member do
      get :following, :followers
    end
    member do
      match :smacks
      match 'smacks/search', :action => :smacks
      match :redemptions
      match 'redemptions/search', :action => :redemptions
    end
  end

  resources :posts do
    member do
      post :report
    end
    member do
      post :vote_up, :vote_down
    end
  end

  resources :conferences, :colleges do
    member do
      match :search, :action => :show
    end
    resources :videos do
       collection do
         match :search, :action => :index
       end
    end
    resources :photos do
       collection do
         match :search, :action => :index
       end
    end
    resources :news, :controller => :news_posts do
       collection do
         match :search, :action => :index
       end
    end
    resources :stats, :controller => :statistics do
       collection do
         match :search, :action => :index
       end
    end
  end

  resources :comments, :only => [:destroy, :edit, :update] do
    member do
      get :report
    end
  end

  resources :smacks, :redemptions, :only => [:show, :index, :destroy] do
    resources :comments, :only => [:create]
  end

  resources :conferences, :colleges, :only => [:index, :show] do
    resources :smacks, :redemptions do
      collection do
        match :search, :action => :index
      end
      resources :videos
      resources :photos
      resources :news, :controller => :news_posts
      resources :stats, :controller => :statistics
    end
  end

  resources :conferences do
    member do
      get :status, :to => 'conferences#status'
    end
  end
  resources :conferences

  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :authentications, :only => [:index, :destroy]
  resources :support, :only => [:new, :create]

  match '/search', :to => 'posts#index'
  get '/contact-us', :to => 'support#new'
  post '/contact-us', :to => 'support#create'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'

  root :to => 'welcome#index'
end

