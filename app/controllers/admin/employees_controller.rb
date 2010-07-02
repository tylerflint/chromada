class Admin::EmployeesController < Admin::AdminController
  # Be sure to include AuthenticationSystem in Application Controller instead
  def dashboard
    
  end
  
  def login
    respond_to do |format|
      format.html do
        employee = Employee.authenticate(params[:login], params[:password])
        if employee
          self.current_employee = employee
          redirect_to admin_dashboard_path
        end
      end
      format.js do
        employee = Employee.authenticate(cookies[:login], cookies[:password])
        if employee
          self.current_employee = employee
          cookies[:login]     = ''
          cookies[:password]  = ''
          render :js => "window.location = '/admin/dashboard'"
        else
          # somehow display an error here
          render :js => "alert('username and password does not match any within the system')"
        end
      end
    end
    # if request.post?
    #   logout_keeping_session!
    #   employee = Employee.authenticate(params[:login], params[:password])
    #   if employee
    #     # Protects against session fixation attacks, causes request forgery
    #     # protection if user resubmits an earlier form using back
    #     # button. Uncomment if you understand the tradeoffs.
    #     # reset_session
    #     self.current_employee = employee
    #     new_cookie_flag = (params[:remember_me] == "1")
    #     handle_remember_cookie! new_cookie_flag
    #     redirect_to admin_dashboard_path
    #   else
    #     note_failed_signin
    #     @login       = params[:login]
    #     @remember_me = params[:remember_me]
    #     render :action => 'login'
    #   end
    # else
    #   render :layout => false
    # end
  end

  def logout
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  # render new.rhtml
  def new
    @employee = Employee.new
    if params[:ajax] == "1"
      render :layout => false
    end
  end
  
  def edit
    @employee = Employee.find(params[:id])
    if params[:ajax] == "1"
      render :layout => false
    end
  end
  
  def update
    @employee = Employee.find(params[:id])
    @employee.update_attributes(params[:employee])
    @employee.save
    respond_to do |format|
      format.html do
        # render :text => @employee.errors.to_s
        redirect_to admin_employees_path @employee
      end
      format.js do
        render :text => "success"
      end
    end
    
  end
 
  def create
    # logout_keeping_session!
    @employee = Employee.new(params[:employee])
    @employee.generate_password #if params[:employee][:generate_password] == 1
    success = @employee && @employee.save
    if success && @employee.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      # self.current_employee = @employee # !! now logged in
      # redirect_back_or_default('/')
      render :action => 'index'
      flash[:notice] = "Employee was successfully created."
    else
      errors = ""
      @employee.errors.each do |k, v|
        errors << k + ": " + v + "<br />"
      end
      render :text => errors
      # flash[:error]  = "Unable to create a new employee."
      # render :action => 'new'
    end
  end
  
  protected
    # Track failed login attempts
    def note_failed_signin
      flash[:error] = "Couldn't log you in as '#{params[:login]}'"
      logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
    end
  
end
