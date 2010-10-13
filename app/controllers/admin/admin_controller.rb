class Admin::AdminController < ApplicationController
  before_filter       :authenticate_user!
  layout              "admin"
  
  def dashboard
    # flash[:notice] = "Hello world"
    # flash[:error] = "Hello world"
    # flash[:alert] = "Hello world"
  end
  
end
