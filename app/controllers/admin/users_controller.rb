class Admin::UsersController < Admin::CompanyController
  
  # GET /users
  def index
    @users = @company.users
    if params[:ajax]
      render :text => simple_list_instance(:user, @users, :display_column => :username).list
    end
  end

  # GET /search
  def search
    @users = User.any_of({:username => /^#{params[:search]}.*/i}, {:email => /^#{params[:search]}.*/i}).limit(5)
    render :layout => false
  end

  # GET /users/1
  def show
    @user = @company.users.find(params[:id])
  end

  # GET /users/new
  def new
    @user = @company.users.build
  end

  # GET /users/1/edit
  def edit
    @user = @company.users.find(params[:id])
  end

  # POST /users
  def create
    begin
      @user = User.first(:conditions => {:username => params[:user][:username]})
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "unknown user"
      redirect_to url_for([:admin, @company, :users])
    end
    @user.companies << @company
    @user.set_permissions( @company, params[:permission_ids].split(',') )
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  # PUT /users/1
  def update
    @user = @company.users.find(params[:id])
    @user.set_permissions( @company, params[:permission_ids].split(',') )
    if @user.update_attributes(params[:user])
      flash[:notice] = "#{@user.username}'s permissions were successfully updated."
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      render :action => :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user = @company.users.find(params[:id])
    username = @user.username
    @user.drop_company(@company)
    @company.drop_user(@user)
    if @user.save && @company.save
      flash[:alert] = "#{username} was successfully removed as an administrator"
      redirect_to :action => :index
    else
      flash[:error] = "We're sorry, please try that again"
      redirect_to [:admin, @company, :edit, @user]
    end
  end
  
end
