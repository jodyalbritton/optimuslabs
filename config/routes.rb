Rails.application.routes.draw do



 
#Users and Roles 
    devise_for :users, :controllers => { :registrations => "registrations", omniauth_callbacks: 'omniauth_callbacks' }
  
 
#Site Features
  resources :sponsors, only: [:index, :show]
  resources :services, only: [:index, :show]
  resources :messages, only: [:new, :create]
  resources :products, only: [:index, :show]
  resources :videos,   only: [:index, :show]
  resources :galleries,   only: [:index, :show] do 
    resources :photos,   only: [:show]
  end 
  resources :contacts, only: [:new, :create, :thanks]
  resources :tags, only: [:index, :show]
  resources :categories, only: [:index, :show]

#Admin interface 

  resources :admin, only: [:index]

  namespace :admin do
      namespace :settings do
       match  'edit_all' => :edit_all, :via => :get
       match  'update_all' => :update_all, :via => :put
      end
      resources :chat_messages, only: [:create]
      resources :company 
      resources :timesheets
      resources :users do
        resources :timesheets
        resources :interactions
      end
      resources :posts do
        post 'crop', :on => :member
        collection do
          get :tags
        end
      end
      resources :products do 
        resources :attachments
        post 'crop', :on => :member
        collection { post :sort }
      end
      resources :categories
      resources :galleries do 
        resources :photos
         collection do
          get :tags
        end
      end

      resources :photos do
         collection do
          get :tags
        end
      end
      resources :videos do
        collection do
          get :tags
        end
      end

      resources :projects do 
        resources :milestones
      end
      resources :interaction_events
      resources :rate_types
      resources :severity_types
      resources :ticket_statuses
      resources :invoice_statuses
      resources :clients do 
        resources :invoices do 
          get :print
          resources :payments
        end
        resources :tasks
        resources :tickets 
        resources :users 

        resources :contacts

      end
      resources :messages
      resources :interactions

      resources :contacts do
        resources :interactions
      end
     
      resources :services do 
          resources :attachments
          post 'crop', :on => :member
         end
      resources :settings do 
        
      end
      resources :invoices do
          resources :payments
          get :print
      end

      resources :payments
      resources :payment_methods
      resources :tickets do
        resources :attachments
        resources :interactions
      end
      resources :notes
      resources :tasks do 
        collection { post :sort }
      end
      resources :sponsors do 
        resources :attachments
        collection do
          get :tags
        end
      end


  end

  #Blog Feature 
   scope '/blog' do
      resources :posts, only: [:show, :tagged, :catagorized]
   end
    
  get 'search/:action' => 'searches#:action'
  get 'blog', to: 'posts#index', :as => 'index'
  get 'blog/posts/tagged/:tag' => 'posts#tagged', :as => 'tagged'
  get 'blog/posts/categories/:category' => 'posts#categorized', :as => 'categorized'
  get '/blog', to: 'posts#index'
  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
 


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  


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
