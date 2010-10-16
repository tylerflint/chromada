class Admin::PermissionsController < Admin::CompanyController

  # GET /roles
  def index
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
  def show
    @permission = @company.permissions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /roles/new
  def new
    @permission = @company.permissions.build

    respond_to do |format|
      format.html { render :template => 'admin/permissions/edit' }
    end
  end

  # GET /roles/1/edit
  def edit
    @permission = @company.permissions.find(params[:id])
  end

  # POST /roles
  def create
    @permission = @company.permissions.build(params[:permission])
    @permission.action_ids = params[:action_ids].split(',')
    
    respond_to do |format|
      if @permission.save
        format.html do
          flash[:notice] = "#{@permission.name} was successfully created."
          redirect_to :action => :index
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /roles/1
  def update
    @permission = @company.permissions.find(params[:id])
    @permission.action_ids = params[:action_ids].split(',')

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html do
          flash[:notice] = "#{@permission.name} was successfully updated."
          redirect_to :action => :index
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /roles/1
  def destroy
    @permission = @company.permissions.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(:action => :index) }
    end
  end
  
end
