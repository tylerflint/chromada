ActionController::Routing::Routes.draw do |map|
  
  map.root                                        :controller => 'static'
                                                  
  map.products          '/products.html',         :controller => 'static',        :action => 'products' 
  map.services          '/services.html',         :controller => 'static',        :action => 'services'
  map.downloads         '/downloads.html',        :controller => 'static',        :action => 'downloads'
  map.support           '/support.html',          :controller => 'static',        :action => 'support'
  map.about             '/about.html',            :controller => 'static',        :action => 'about'
  map.contact           '/contact.html',          :controller => 'static',        :action => 'contact'
  
  map.send_feedback     '/send-feedback.html',    :controller => 'static',        :action => 'send_feedback'
  map.privacy_policy    '/privacy-policy.html',   :controller => 'static',        :action => 'privacy_policy'
  map.terms_of_use      '/terms-of-use.html',     :controller => 'static',        :action => 'terms_of_use'
                                                  
  map.namespace :admin do |admin|             
    admin.root                                    :controller => 'employees',     :action => 'dashboard'
    admin.dashboard     '/dashboard',             :controller => 'employees',     :action => 'dashboard'
    admin.logout        '/logout',                :controller => 'employees',     :action => 'logout'
    admin.login         '/login.:format',                 :controller => 'employees',     :action => 'login'
    admin.resources                               :employees
    admin.resource                                :session
  end
  
  # map.logout '/logout', :controller => 'admin/sessions', :action => 'destroy'
  # map.login '/login', :controller => 'admin/sessions', :action => 'new'
  # map.register '/register', :controller => 'employees', :action => 'create'
  # map.signup '/signup', :controller => 'employees', :action => 'new'
  # map.resources :employees

  # map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
