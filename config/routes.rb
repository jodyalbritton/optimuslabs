Rails.application.routes.draw do



  get 'labs/platform'

  get 'labs/helpdesk'

  get 'labs/future'

#Users and Roles 
  devise_for :users
  concern :the_role, TheRole::AdminRoutes.new
 
 
#Site Features
  resources :sponsors, only: [:index, :show]
  resources :services, only: [:index, :show]
  resources :messages, only: [:new, :create]
  resources :products, only: [:index, :show]
  resources :contacts, only: [:new, :create, :thanks]
  

#Admin interface 
  resources :admin, only: [:index]
  namespace :admin do
      resources :posts
      resources :products
      resources :categories
      resources :rate_types
      resources :clients do 
        resources :invoices
        resources :tasks
        resources :tickets
      end
      resources :messages
      resources :interactions
      resources :contacts do
        resources :interactions
      end
      resources :settings
      resources :services
      resources :invoices
      resources :tickets do
        resources :interactions
      end
      resources :notes
      resources :tasks
      resources :sponsors
      concerns :the_role

  end

  #Blog Feature 
   scope '/blog' do
      resources :posts, only: [:show, :tagged, :catagorized]
  end
    
  
  get 'blog', to: 'posts#index', :as => 'index'
  get 'blog/posts/tagged/:tag' => 'posts#tagged', :as => 'tagged'
  get 'blog/posts/categories/:category' => 'posts#categorized', :as => 'categorized'

  
  # Static Pages
  get 'welcome/index'
  get '/about', to:'welcome#about'
  get '/contact', to: 'welcome#contact'
  get '/blog', to: 'posts#index'
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
   root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
