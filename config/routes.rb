Chromada::Application.routes.draw do
  
  root :to => "static#index", :protocol => 'http'
  
  # sinatra app for quick deploys via post-receive-hooks
  match "/deploy" => GitDeployApp
  
  devise_for :users,
    # :path => "/",
    :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }, 
    :controllers => { :sessions => "sessions", :registrations => 'registrations' }
  
    scope "", :protocol => 'http' do

      match "products"    => "static#products",     :as => "products"
      match "how"         => "static#how",          :as => "how"      
      match "pricing"     => "static#pricing",      :as => "pricing"
      match "contact"     => "static#contact",      :as => "contact"                                        
      match "feedback"    => "static#feedback",     :as => "feedback"
      match "privacy"     => "static#privacy",      :as => "privacy"
      match "terms"       => "static#terms",        :as => "terms"

    end
  
  namespace :admin, :path => "admin", :protocol => (Rails.env.production?)? 'https' : 'http'  do
    root :to                                    => "admin#dashboard"
    match "dashboard"                           => "admin#dashboard",     :as => "dashboard"
    match "companies/:id/dashboard"             => "companies#dashboard", :as => "company_dashboard"
    match "companies/:company_id/users/search"  => "users#search",        :as => "search_company_users"
    resources :companies do
      resources :employees
      resources :permissions
      resources :users
    end
  end
  
end
