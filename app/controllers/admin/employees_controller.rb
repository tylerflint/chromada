class Admin::EmployeesController < Admin::AdminController
  # Be sure to include AuthenticationSystem in Application Controller instead
  def dashboard
    # session[:firstname] = 'Tyler'
    # session[:lastname]  = 'Flint'
    # session[:test] = {}
    # session[:test][:firstname]  = 'Brittany'
    # session[:test][:lastname]   = 'Flint'
  end
  
  def login
    if request.post?
      logout_keeping_session!
      employee = Employee.authenticate(params[:login], params[:password])
      if employee
        # Protects against session fixation attacks, causes request forgery
        # protection if user resubmits an earlier form using back
        # button. Uncomment if you understand the tradeoffs.
        # reset_session
        self.current_employee = employee
        new_cookie_flag = (params[:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
        redirect_to admin_dashboard_path
      else
        note_failed_signin
        @login       = params[:login]
        @remember_me = params[:remember_me]
        render :action => 'login'
      end
    else
      render :layout => false
    end
  end

  def logout
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  # render new.rhtml
  def new
    @employee = Employee.new
    render :template => 'admin/employees/edit.html.erb'
  end
  
  def edit
    @employee = Employee.find(params[:id])
  end
 
  def update
    @employee = Employee.find(params[:id])
    @employee.update_attributes(params[:employee])
    @employee.save
    redirect_to edit_admin_employee_path @employee
  end
 
  def create
    logout_keeping_session!
    @employee = Employee.new(params[:employee])
    success = @employee && @employee.save
    if success && @employee.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_employee = @employee # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  protected
    # Track failed login attempts
    def note_failed_signin
      flash[:error] = "Couldn't log you in as '#{params[:login]}'"
      logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
    end
  
end
