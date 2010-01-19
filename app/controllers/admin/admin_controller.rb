class Admin::AdminController < ApplicationController
  before_filter :validate_logged_in
  layout "admin"
  
  protected
  
    def validate_logged_in
      redirect_to admin_login_url if !logged_in?
    end
    
end
