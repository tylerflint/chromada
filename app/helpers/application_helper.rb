# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def flash_helper

      message_type = [:notice, :warning, :error]
      display = ''

      for message in message_type
        if flash[message]
          display = display + "<div class=\"#{message} message\">#{flash[message]}</div>"
        end
        
      flash[message] = nil;
    end
    
    return display
  end
  
end