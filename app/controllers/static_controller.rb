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
  
  def privacy
    @active = 'privacy'
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
  
  def tou
    @active = 'tou'
    @title="Chromada - Terms of Use"
  end
end
