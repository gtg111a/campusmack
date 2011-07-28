Campusmack::Application.routes.draw do
    get "sessions/new"
        
    
    resources :services, :only => [:index, :create]
    resources :comments
    resources :smacks, :redemptions, :posts, do
      resources :comments, :only => [:create,:destroy, :edit]
      member do
        post :vote_up, :vote_down
      end
    end
    resources :users do
      resources :colleges, :only => [:show] do
          resources :posts
          resources :smacks
          resources :redemptions
        end
      member do
        get :following, :followers
      end
    end
    resources :sessions, :only => [:new, :create, :destroy]
    resources :microposts, :only => [:create, :destroy]
    resources :relationships, :only => [:create, :destroy]
    resources :colleges, :only => [:new, :create, :show] do
      resources :smacks, :redemptions, :posts, :only => [:show, :index, :destroy] do
      member do
        post :vote_up, :vote_down
      end
    end
  end
    
    match '/signup', :to => 'users#new'
    match '/signin', :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy'
    match '/contact', :to => 'pages#contact'
    match '/about', :to => 'pages#about'
    match '/help', :to => 'pages#help'
    match '/auth/:provider/callback' => 'services#create'
    #match '/users/:id' :to => 'users#show'


    root :to => 'pages#home'
    
      # Allow downloading Web Service WSDL as a file with an extension
    	# instead of a file named 'wsdl'
    	#map.connect ':controller/service.wsdl', :action => 'wsdl'

     	# Install the default route as the lowest priority
     	#map.connect ':controller/:action/:id.:format'
     	#map.connect ':controller/:action/:id'

    # The priority is based upon order of creation:
    # first created -> highest priority.

    # Sample of regular route:
    #   match 'products/:id' => 'catalog#view'
    # Keep in mind you can assign values other than :controller and :action

    # Sample of named route:
    #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
    # This route can be invoked with purchase_url(:id => product.id)

    # Sample resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Sample resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Sample resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Sample resource route with more complex sub-resources
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', :on => :collection
    #     end
    #   end

    # Sample resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end

    # You can have the root of your site routed with "root"
    # just remember to delete public/index.html.
    # root :to => "welcome#index"

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id(.:format)))'
  end

