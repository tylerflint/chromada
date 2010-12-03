Chromada::Application.routes.draw do
  
  root :to => "static#index"
  
  devise_for :users,
    # :path => "/",
    :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }, 
    :controllers => { :sessions => "sessions", :registrations => 'registrations' }
  
  match "products"    => "static#products",     :as => "products"
  match "services"    => "static#services",     :as => "services"      
  match "downloads"   => "static#downloads",    :as => "downloads"
  match "support"     => "static#support",      :as => "support"
  match "about"       => "static#about",        :as => "about"
  match "contact"     => "static#contact",      :as => "contact"                                        
  match "feedback"    => "static#feedback",     :as => "feedback"
  match "privacy"     => "static#privacy",      :as => "privacy"
  match "tou"         => "static#tou",          :as => "tou"
  
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
