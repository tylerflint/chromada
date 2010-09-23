class Admin::CompanyController < Admin::AdminController
  
  before_filter :load_company, :init_permissions
  
  protected
  
  def load_company
    begin
      @company = current_user.companies.find(params[:company_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid company"
      redirect_to admin_dashboard_url
    end
  end
  
  def init_permissions
    Mother.set_company(@company)
    Mother.set_child(current_user)
  end
  
end