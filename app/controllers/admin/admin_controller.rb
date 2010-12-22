class Admin::AdminController < ApplicationController
  before_filter       :authenticate_user!
  layout              "admin"
  
  def index
    if company = current_user.companies.first
      redirect_to admin_company_dashboard_url(company)
    end
  end
  
end
