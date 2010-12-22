class Admin::CompanyController < Admin::AdminController
  
  before_filter :load_company
  
  protected
  
  def load_company
    begin
      @company = current_user.companies.find(params[:company_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid company"
      redirect_to admin_root_url
    end
  end
  
end