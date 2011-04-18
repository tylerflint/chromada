class StaticController < ApplicationController
  
  def index
    @active = 'index'
    @title="Chromada - Home"
  end
  
  def privacy_policy
    @active = 'privacy'
    @title="Chromada - Privacy Policy"
  end
  
  def terms_of_use
    @active = 'terms'
    @title="Chromada - Terms of Use"
  end
  
end
