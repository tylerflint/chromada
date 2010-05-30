Chromada::Application.routes.draw do |map|
  
  # replace these soon
  
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
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
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
