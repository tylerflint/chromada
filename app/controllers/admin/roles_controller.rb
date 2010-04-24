class Admin::RolesController < Admin::AdminController
  before_filter :find_role, :only => [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.xml
  def index
    @roles = Role.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |wants|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        wants.html { redirect_to(@role) }
        wants.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        wants.html { render :action => "new" }
        wants.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    respond_to do |wants|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        wants.html { redirect_to(@role) }
        wants.xml  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role.destroy

    respond_to do |wants|
      wants.html { redirect_to(roles_url) }
      wants.xml  { head :ok }
    end
  end

  private
    def find_role
      @role = Role.find(params[:id])
    end
    
end

