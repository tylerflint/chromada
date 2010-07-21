class SessionsController < Devise::SessionsController
  # POST /login
  def create
    respond_to do |format|
      format.js do
        
      end
      format.html do
        resource = warden.authenticate!(:scope => resource_name, :recall => "new")
        set_flash_message :notice, :signed_in
        sign_in_and_redirect(resource_name, resource)
      end
    end
  end
  
end
