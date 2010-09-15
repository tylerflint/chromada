class Admin::UsersController < Admin::AdminController
  before_filter :load_company
  
  # GET /users
  # GET /users.xml
  def index
    @users = @company.users.scoped
    respond_to do |format|
      format.html do
        if params[:ajax]
          render :text => simple_list_instance(:user, @users, :display_column => :username).list
        end
      end
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = @company.users.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = @company.users.build

    respond_to do |format|
      format.html { render :template => 'admin/users/edit' }
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = @company.users.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = @company.users.build(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(:action => :index, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = @company.users.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(:action => :index, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = @company.users.find(params[:id])
    @user.destroy

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
