class SessionsController < Devise::SessionsController
  
  # POST /login
  def create
    respond_to do |format|
  
      format.js do
        # prepare_params_from_cookie
        # render :js => "alert('#{warden.request.params.to_s}')"
        prepare_params_from_cookie
        clean_cookies
        warden.request.params[:user] = {:email => "tylerflint@gmail.com", :password => "password", :remember_me => "0"}
        render :js => "alert('#{warden.authenticate?.to_s}')"
        # if warden.authenticate?
        #   sign_in(resource_name)
        #   render :js => "window.location = '/admin/dashboard'"
        # else
        #   # render :js => "alert('username and password does not match any within the system')"
        #   render :js => "alert('#{warden.request.params.to_s}')"
        # end
      end
      
      format.html do
        resource = warden.authenticate!(:scope => resource_name, :recall => "new")
        sign_in(resource_name, resource)
        redirect_to admin_dashboard_path
      end
    end
  end
  
protected
  
  def prepare_params_from_cookie
    warden.request.params[:user] = {:email => "tylerflint@gmail.com", :password => "password", :remember_me => "0"}
    # warden.request.params[:user] = {:email => cookies[:login], :password => cookies[:password]}
    # params[:user] = {:email => cookies[:login], :password => cookies[:password]}
  end
  
  def clean_cookies
    cookies[:login]     = ''
    cookies[:password]  = ''
  end
  
end
