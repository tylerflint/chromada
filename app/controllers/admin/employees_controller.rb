class Admin::EmployeesController < Admin::CompanyController
  
  # GET /employees
  def index
    @employees = @company.employees
    if params[:ajax]
      render :text => simple_list_instance(:employee, @employees).list
    end
  end

  # GET /employees/1
  def show
    @employee = @company.employees.find(params[:id])
  end

  # GET /employees/new
  def new
    @employee = @company.employees.build
    render :template => 'admin/employees/edit'
  end

  # GET /employees/1/edit
  def edit
    @employee = @company.employees.find(params[:id])
  end

  # POST /employees
  def create
    @employee = @company.employees.build(params[:employee])
    if @employee.save
      flash[:notice] = "#{@employee.name} was successfully created."
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      render :action => :new
    end
  end

  # PUT /employees/1
  def update
    @employee = @company.employees.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:notice] = "#{@employee.name} was successfully updated."
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      render :action => :edit
    end
  end

  # DELETE /employees/1
  def destroy
    @employee = @company.employees.find(params[:id])
    employee_name = @employee.name
    if @employee.destroy
      flash[:notice] = "#{employee_name} was successfully removed"
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      redirect_to [:admin, @company, :edit, @employee]
    end
  end
  
end
