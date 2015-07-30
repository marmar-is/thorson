Rails.application.routes.draw do
  devise_for :accounts

  authenticated :account do
    root 'statics#index'
  end

  root 'statics#portal', as: :unauthenticated_root

  resources :risk_profiles do
    member do
      patch 'update_status'
      post 'create_quote'
      patch 'issue_quote'
      get 'view_quote/:quote_id' => 'risk_profiles#view_quote', as: 'view_quote'
      patch 'update_rating/:rating_id' => 'risk_profiles#update_rating', as: 'update_rating'
    end
  end
  resources :factors, only: [ :index ]

  resources :broker_accts, only: [ :new, :create, :update ]
  get 'profile' => 'broker_accts#profile', as: :broker_profile

  resources :employee_accts, only: [ :new, :create, :update ]

  resources :ratings, only: [ :index ]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
