class Admin::EmployeesController < Admin::AdminController
  before_filter :load_company
  
  # GET /employees
  # GET /employees.xml
  def index
    @employees = @company.employees.scoped
    respond_to do |format|
      format.html do
        if params[:ajax]
          simple_list_instance(:employee, @employees).list
        end
      end
      format.xml  { render :xml => @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.xml
  def show
    @employee = @company.employees.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.xml
  def new
    @employee = @company.employees.build

    respond_to do |format|
      format.html { render :template => 'admin/employees/edit' }
      format.xml  { render :xml => @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = @company.employees.find(params[:id])
  end

  # POST /employees
  # POST /employees.xml
  def create
    @employee = @company.employees.build(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to(@employee, :notice => 'Employee was successfully created.') }
        format.xml  { render :xml => @employee, :status => :created, :location => @employee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.xml
  def update
    @employee = @company.employees.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to(:action => :index, :notice => 'Employee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.xml
  def destroy
    @employee = @company.employees.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to(employees_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def load_company
    @company = Company.find(params[:company_id])
  end
  
end
