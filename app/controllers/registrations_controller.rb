class RegistrationsController < Devise::RegistrationsController
  
  def after_sign_in_path_for(resource_or_scope)
    admin_root_url
  end
  
  def new
    # render page
  end
  
end