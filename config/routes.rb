Tookoda::Application.routes.draw do
  get "projects/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :contamination_sources
  resources :groups
  resources :group_elements
  resources :snaps
  resources :chemicals
  
  resources :chemical_elements do
    get :chemical_elements, to: :index
    get :autocomplete_v_group_element_cas, :on => :collection
  end
  
  resources :pollution_permit_chemicals do
    get :calculate, :on => :member
    get :autocomplete_chemical_name, :on => :collection
    get :autocomplete_snap_name, :on => :collection
  end
  
  resources :projects do
    get :calculate, :on => :member
    get :print, :on => :member
    get :project_chemicals, :on => :member
    post :create_project_chemical, :on => :collection
    get :autocomplete_chemical_name, :on => :collection
    get :autocomplete_snap_name, :on => :collection
  end
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
  #root :to => 'projects#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
