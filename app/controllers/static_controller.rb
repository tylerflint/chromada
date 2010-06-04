class StaticController < ApplicationController
  
  def index
    @active = 'index'
    @title="Chromada - Home"
  end
  
  def about
    @active = 'about'
    @title="Chromada - About"
  end
  
  def contact
    @active = 'contact'
    @title="Chromada - Contact"
  end
  
  def downloads
    @active = 'downloads'
    @title="Chromada - Downloads"
  end
  
  def privacy_policy
    @active = 'privacy-policy'
    @title="Chromada - Privacy Policy"
  end
  
  def products
    @active = 'products'
    @title="Chromada - Products"
  end
  
  def feedback
    @active = 'send-feedback'
    @title="Chromada - Send Feedback"
  end
  
  def services
    @active = 'services'
    @title="Chromada - Services"
  end
  
  def support
    @active = 'support'
    @title="Chromada - Support"
  end
  
  def terms_of_use
    @active = 'terms-of-use'
    @title="Chromada - Terms of Use"
  end
end
