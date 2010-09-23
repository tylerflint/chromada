class Admin::CompaniesController < Admin::AdminController

  before_filter :load_company, :init_permissions, :except => [:index, :new, :create]

  # GET /companies
  # GET /companies.xml
  def index
    @companies = current_user.companies.scoped

    respond_to do |format|
      format.html do
        if params[:ajax]
          render :text => simple_list_instance(:company, @companies, {:item_url => "admin_company_dashboard_url"}).list
        end
      end
      format.xml  { render :xml => @companies }
    end
  end
  
  def dashboard
    
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html { render :template => 'admin/companies/edit' }
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.create(params[:company])
    
    respond_to do |format|
      if @company.save 
      # if @company
        add_company_to_user(@company)
        format.html { redirect_to(admin_company_dashboard_url(@company), :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(admin_company_dashboard_url(@company), :notice => 'Company was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(admin_companies_url) }
      format.xml  { head :ok }
    end
  end

  protected
  
  def load_company
    begin
      @company = current_user.companies.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid company"
      redirect_to admin_dashboard_url
    end
  end
  
  def init_permissions
    Mother.set_company(@company)
    Mother.set_child(current_user)
  end
  
  def add_company_to_user(company)
    current_user.companies << company
    current_user.save
  end

end
