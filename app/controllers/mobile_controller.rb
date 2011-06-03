class MobileController < ApplicationController
  
  layout 'mobile'
  
  skip_before_filter :check_mobile
  
  def index
    @title  = 'Chromada - Home'
  end
  
  def privacy_policy
    @title  = 'Chromada - Privacy Policy'
  end
  
  def terms_of_use
    @title  = 'Chromada - Terms of Use'
  end
  
  def contact
    puts params[:contact]
  end
  
end
