# frozen_string_literal: true

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

  #resource :user_session
  root :controller => "user_sessions", :action => "new" # first page user sees is the login page
  #map.root :controller => :recipients

  resources :recipients, :collection => { :show_map => :get } do
    resources :deliveries, :member => { :delivery_sheet => :get } do
      resources :delivered_items
    end
  end

  # to allow for top level index view
  resources :deliveries, :member => { :add_to_worksheet => :put }
  resources :donor_pickups, :member => { :add_to_worksheet => :put }

  # TODO: remove :member => { :add_to_worksheet => :put }
  resources :donors, :member => { :add_to_worksheet => :put } do
    resources :donor_items
    resources :donor_pickups, :member => { :delivery_sheet => :get } do
      resources :pickedup_items
    end
  end

  resources :items
  resources :case_workers
  resources :organizations
  resources :reports, :member => { :deliveries_stats => :get }

  resources :users
  resource :account, :controller => "users"

  resources :user_sessions

  # special routes for login and logout
  get "login", :controller => "user_sessions", :action => "new"
  delete "logout", :controller => "user_sessions", :action => "destroy"

  resources :daily_worksheets, :member => { :reorder => :get, :print_worksheet => :get } do
		resources :daily_deliveries   # was map.resources ....
  end

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
