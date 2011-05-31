Chromada::Application.routes.draw do
  
  # sinatra app for quick deploys via post-receive-hooks
  match '/deploy'                                  => GitDeployApp
  
  ### SITE (WEB)
  root :to                                         => 'web#index'
  
  get 'privacy-policy'                             => 'web#privacy_policy'
  get 'terms-of-use'                               => 'web#terms_of_use'
  post 'contact'                                   => 'web#contact'
  
  ### SITE (MOBILE)
  get 'mobile'                                     => 'mobile#index'
  
  # devise_for :users,
  #     # :path                                    => "/",
  #     :path_names                                => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }, 
  #     :controllers                               => { :sessions => "sessions", :registrations => 'registrations' }

  # namespace :admin, :path                        => "admin", :protocol => (Rails.env.production?)? 'https' : 'http'  do
  #     root :to                                   => "admin#index"
  #     match "companies/:id/dashboard"            => "companies#dashboard", :as => "company_dashboard"
  #     match "companies/:company_id/users/search" => "users#search",        :as => "search_company_users"
  #     resources :companies do
  #       resources :employees
  #       resources :permissions
  #       resources :users
  #     end
  #   end
  
end
