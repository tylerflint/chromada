class StaticController < ApplicationController
  
  def index
    @active = 'index'
    @title="Chromada - Home"
  end
  
  def contact
    @active = 'contact'
    @title="Chromada - Contact"
  end
  
  def downloads
    @active = 'downloads'
    @title="Chromada - Downloads"
  end
  
  def pricing
    @active = 'how'
    @title="Chromada - how it works"
  end
  
  def how
    @active = 'pricing'
    @title="Chromada - pricing"
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
  
  def terms
    @active = 'terms'
    @title="Chromada - Terms of Use"
  end
end
