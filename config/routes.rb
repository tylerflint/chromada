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
  
  namespace :admin, :path => "admin", :protocol => (Rails.env.production?)? 'https' : 'http'  do
    root :to                    => "admin#dashboard"
    match "dashboard"           => "admin#dashboard", :as => "dashboard"
    resources :companies do
      resources :employees
      resources :roles
    end
  end
  
end
