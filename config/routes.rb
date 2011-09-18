Campusmack::Application.routes.draw do
  resources :contacts do
    collection do
      post 'import'
    end
  end

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
      get :following, :followers
      get 'plaxo_import'
    end
  end

  resources :posts do
    member do
      get :report
      get "opengraph"
      get 'share_through_email_form'
      post 'share_through_email'
    end
    member do
      post :vote_up, :vote_down
    end
  end

  resources :conferences, :colleges do
    resources :videos
    resources :photos
    resources :news, :controller => :news_posts
    resources :stats, :controller => :statistics
  end

  resources :comments, :only => [:destroy, :edit, :update]

  resources :smacks, :redemptions, :only => [:show, :index, :destroy] do
    resources :comments, :only => [:create]
  end

  resources :conferences, :colleges, :only => [:index, :show] do
    resources :smacks, :redemptions do
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

  resources :microposts, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :authentications, :only => [:index, :destroy]
  resources :support, :only => [:new, :create]
  get '/reports', :to => 'reports#index'

  match '/search', :to => 'posts#index'
  get '/contact-us', :to => 'support#new'
  post '/contact-us', :to => 'support#create'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'

  root :to => 'welcome#index'
end

