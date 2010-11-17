class Admin::CompaniesController < Admin::AdminController

  before_filter :load_company, :except => [:index, :new, :create]

  # GET /companies
  def index
    @companies = current_user.companies

    respond_to do |format|
      format.html do
        if params[:ajax]
          render :text => simple_list_instance(:company, @companies, {:item_url => "admin_company_dashboard_url"}).list
        end
      end
    end
  end
  
  def dashboard
    
  end

  # GET /companies/1
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /companies/new
  def new
    @company = Company.new

    respond_to do |format|
      format.html { render :template => 'admin/companies/edit' }
    end
  end

  # GET /companies/1/edit
  def edit
    
  end

  # POST /companies
  def create
    @company = Company.create(params[:company])
    respond_to do |format|
      if @company.save 
        add_company_to_user(@company)
        format.html do
          flash[:notice] = "#{@company.name} was successfully created."
          redirect_to admin_company_dashboard_url(@company)
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /companies/1
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html do
          flash[:notice] = "#{@company.name} was successfully updated."
          redirect_to( admin_company_dashboard_url(@company) )
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to(admin_companies_url) }
    end
  end

  protected
  
  def load_company
    begin
      @company = current_user.companies.find(params[:id], {:readonly => false})
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid company"
      redirect_to admin_dashboard_url
    end
  end
  
  def add_company_to_user(company)
    current_user.companies << company
    company.add_owner(current_user)
    company.save
  end

end
