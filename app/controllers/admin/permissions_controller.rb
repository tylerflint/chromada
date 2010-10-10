class Admin::PermissionsController < Admin::CompanyController

  # GET /roles
  # GET /roles.xml
  def index
    # @permissions = @company.permissions.scoped
    @permissions = @company.permissions
    respond_to do |format|
      format.html do
        if params[:ajax]
          render :text => simple_list_instance(:permission, @permissions).list
        end
      end
      format.xml  { render :xml => @permissions }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    # @permission = Role.find(params[:id])
    @permission = @company.permissions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    # @permission = Role.new
    @permission = @company.permissions.build

    respond_to do |format|
      format.html { render :template => 'admin/permissions/edit' }
      format.xml  { render :xml => @permission }
    end
  end

  # GET /roles/1/edit
  def edit
    # @permission = Role.find(params[:id])
    @permission = @company.permissions.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    # render :text => params[:permission].to_s
    @permission = @company.permissions.build(params[:permission])
    @permission.action_ids = params[:action_ids].split(',')
    
    respond_to do |format|
      if @permission.save
        format.html { redirect_to(:action => :index, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @permission, :status => :created, :location => [:admin, @company, @permission] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    # @permission = Role.find(params[:id])
    @permission = @company.permissions.find(params[:id])
    @permission.action_ids = params[:action_ids].split(',')

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to(:action => :index, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    # @permission = Role.find(params[:id])
    @permission = @company.permissions.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.xml  { head :ok }
    end
  end
  
end
