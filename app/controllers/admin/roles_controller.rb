class Admin::RolesController < Admin::AdminController
  before_filter :load_company

  # GET /roles
  # GET /roles.xml
  def index
    # @roles = Role.all
    @roles = @company.roles

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    # @role = Role.find(params[:id])
    @role = @company.roles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    # @role = Role.new
    @role = @company.roles.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    # @role = Role.find(params[:id])
    @role = @company.roles.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    # render :text => params[:role].to_s
    @role = @company.roles.build(params[:role])
    @role.action_ids = params[:action_ids].split(',')
    
    respond_to do |format|
      if @role.save
        format.html { redirect_to(:action => :index, :notice => 'Role was successfully created.') }
        format.xml  { render :xml => @role, :status => :created, :location => [:admin, @company, @role] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    # @role = Role.find(params[:id])
    @role = @company.roles.find(params[:id])
    @role.action_ids = params[:action_ids].split(',')

    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(:action => :index, :notice => 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    # @role = Role.find(params[:id])
    @role = @company.roles.find(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(:action => :index) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def load_company
    @company = Company.find(params[:company_id])
  end
  
end
