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
  
  ### USERS
  post 'register'                                  => 'users#register'
  
end
