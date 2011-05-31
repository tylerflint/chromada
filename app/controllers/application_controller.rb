class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all
  
  layout 'site'
  
  before_filter :check_mobile
  
  def check_mobile
    user_agent = request.env['HTTP_USER_AGENT'].downcase
    if user_agent =~ /mobile|webos|iphone|ipad|palm|blackberry|nokia|portable|sprint|android|motorola|ericsson|mobi/
      redirect_to '/mobile'
    end
  end
end
