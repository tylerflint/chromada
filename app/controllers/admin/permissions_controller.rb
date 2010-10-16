class Admin::PermissionsController < Admin::CompanyController

  # GET /permissions
  def index
    @permissions = @company.permissions
    if params[:ajax]
      render :text => simple_list_instance(:permission, @permissions).list
    end
  end

  # GET /permissions/1
  def show
    @permission = @company.permissions.find(params[:id])
  end

  # GET /permissions/new
  def new
    @permission = @company.permissions.build
    render :template => 'admin/permissions/edit'
  end

  # GET /permissions/1/edit
  def edit
    @permission = @company.permissions.find(params[:id])
  end

  # POST /permissions
  def create
    @permission = @company.permissions.build(params[:permission])
    @permission.action_ids = params[:action_ids].split(',')
    if @permission.save
      flash[:notice] = "#{@permission.name} set was successfully created."
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      render :action => "new"
    end
  end

  # PUT /permissions/1
  def update
    @permission = @company.permissions.find(params[:id])
    @permission.action_ids = params[:action_ids].split(',')
    if @permission.update_attributes(params[:permission])
      flash[:notice] = "#{@permission.name} permission set was successfully updated."
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      redirect_to [:admin, @company, :edit, @permission]
    end
  end

  # DELETE /permissions/1
  def destroy
    @permission = @company.permissions.find(params[:id])
    permission_name = @permission.name
    if @permission.destroy
      flash[:notice] = "#{permission_name} permission set has successfully been removed"
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      redirect_to [:admin, @company, :edit, @permission]
    end
  end
  
end
