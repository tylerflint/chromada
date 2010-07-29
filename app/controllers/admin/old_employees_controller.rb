class Admin::EmployeesController < Admin::AdminController
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  def dashboard
    
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
  
end
