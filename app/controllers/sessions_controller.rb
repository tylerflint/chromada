class SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource_or_scope)
    admin_root_url
  end
  
end