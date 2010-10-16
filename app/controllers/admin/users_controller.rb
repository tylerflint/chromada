class Admin::UsersController < Admin::CompanyController
  
  # GET /users
  def index
    @users = @company.users
    respond_to do |format|
      format.html do
        if params[:ajax]
          render :text => simple_list_instance(:user, @users, :display_column => :username).list
        end
      end
    end
  end

  # GET /users/1
  def show
    @user = @company.users.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    @user = @company.users.build

    respond_to do |format|
      format.html { render :template => 'admin/users/edit' }
    end
  end

  # GET /users/1/edit
  def edit
    @user = @company.users.find(params[:id])
  end

  # POST /users
  def create
    begin
      # @user = User.find_by_username(params[:user][:username])
      @user = User.first(:conditions => {:username => params[:user][:username]})
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "unknown user"
      redirect_to url_for([:admin, @company, :users])
    end
    
    @user.companies << @company
    @user.set_permissions( @company, params[:permission_ids].split(',') )
    respond_to do |format|
      if @user.save
        format.html do
          flash[:notice] = 'User was successfully created.'
          redirect_to :action => :index
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @user = @company.users.find(params[:id])
    @user.set_permissions( @company, params[:permission_ids].split(',') )

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html do
          flash[:notice] = 'User was successfully updated.'
          redirect_to :action => :index
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = @company.users.find(params[:id])
    @user.drop_company(@company)
    @company.drop_user(@user)
    @user.save
    @company.save
    respond_to do |format|
      format.html { redirect_to(:action => :index) }
    end
  end
  
end
