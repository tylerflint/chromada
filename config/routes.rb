Chromada::Application.routes.draw do |map|
  
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }, :controllers => { :sessions => 'sessions'}
  # until devise supports default routes explicitly, I have to do this
  # get 'quick_login',  :to => 'sessions#create',    :as => "user_session", :format => :js
  post 'login', :to => 'sessions#create',           :as => "user_session", :format => :html
  get 'login',  :to => 'sessions#new',              :as => "new_user_session"
  get 'logout', :to => 'sessions#destroy',          :as => "destroy_user_session"
  get 'signup', :to => 'devise/registrations#new',  :as => "new_user_registration"
  
  root :to => "static#index"
  
  match "products"         => "static#products",         :as => "products"
  match "services"         => "static#services",         :as => "services"      
  match "downloads"        => "static#downloads",        :as => "downloads"
  match "support"          => "static#support",          :as => "support"
  match "about"            => "static#about",            :as => "about"
  match "contact"          => "static#contact",          :as => "contact"                                        
  match "feedback"         => "static#feedback",         :as => "feedback"
  match "privacy-policy"   => "static#privacy_policy",   :as => "privacy_policy"
  match "terms-of-use"     => "static#terms_of_use",     :as => "terms_of_use"
  
  namespace :admin do
    root :to                    => "admin#dashboard"
    match "dashboard"           => "admin#dashboard"
    resources :companies do
      resources :employees
      resources :roles
    end
  end
  
  # map.namespace :admin do |admin|             
  #   admin.root                                    :controller => 'employees',     :action => 'dashboard'
  #   admin.dashboard     '/dashboard',             :controller => 'employees',     :action => 'dashboard'
  #   admin.logout        '/logout',                :controller => 'employees',     :action => 'logout'
  #   admin.login         '/login.:format',         :controller => 'employees',     :action => 'login'
  #   admin.resources                               :employees
  #   admin.resource                                :session
  # end
  
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
  
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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
