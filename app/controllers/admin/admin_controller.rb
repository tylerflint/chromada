class Admin::AdminController < ApplicationController
  include             AuthenticatedSystem
  before_filter       :validate_logged_in
  skip_before_filter  :validate_logged_in, :only => [:login]
  layout              "admin"
  
  protected
  
    def validate_logged_in
      redirect_to admin_login_url if !logged_in?
    end
    
end
