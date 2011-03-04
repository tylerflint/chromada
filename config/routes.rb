Chromada::Application.routes.draw do
  
  # sinatra app for quick deploys via post-receive-hooks
  match "/deploy" => GitDeployApp
  
  root :to => "static#index", :protocol => 'http'
  
  scope "", :protocol => 'http' do
    match "privacy-policy" => "static#privacy"
    match "terms-of-use" => "static#terms"
  end
  
  # devise_for :users,
  #     # :path => "/",
  #     :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }, 
  #     :controllers => { :sessions => "sessions", :registrations => 'registrations' }

  # namespace :admin, :path => "admin", :protocol => (Rails.env.production?)? 'https' : 'http'  do
  #     root :to                                    => "admin#index"
  #     match "companies/:id/dashboard"             => "companies#dashboard", :as => "company_dashboard"
  #     match "companies/:company_id/users/search"  => "users#search",        :as => "search_company_users"
  #     resources :companies do
  #       resources :employees
  #       resources :permissions
  #       resources :users
  #     end
  #   end
  
end
