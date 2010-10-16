class Admin::EmployeesController < Admin::CompanyController
  
  # GET /employees
  def index
    # @employees = @company.employees.scoped
    @employees = @company.employees
    respond_to do |format|
      format.html do
        if params[:ajax]
          render :text => simple_list_instance(:employee, @employees).list
        end
      end
      format.xml  { render :xml => @employees }
    end
  end

  # GET /employees/1
  def show
    @employee = @company.employees.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /employees/new
  def new
    @employee = @company.employees.build

    respond_to do |format|
      format.html { render :template => 'admin/employees/edit' }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = @company.employees.find(params[:id])
  end

  # POST /employees
  def create
    @employee = @company.employees.build(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html do
          flash[:notice] = "#{@employee.name} was successfully created."
          redirect_to :action => :index
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /employees/1
  def update
    @employee = @company.employees.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html do
          flash[:notice] = "#{@employee.name} was successfully updated."
          redirect_to :action => :index
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /employees/1
  def destroy
    @employee = @company.employees.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to(:action => :index) }
    end
  end
  
end
