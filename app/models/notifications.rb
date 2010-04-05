class Notifications < ActionMailer::Base
  def quote(email_params)
      subject "[Request a Quote Form]: " << email_params[:company]
      recipients "commerce@delorum.com"
      from email_params[:email]
      sent_on Time.now.utc
      
      body  :name         => email_params[:name], 
            :company      => email_params[:company],
            :phone        => email_params[:phone],
            :reference    => email_params[:reference],
            :email        => email_params[:email],
            :web          => email_params[:web],
            :budget       => email_params[:budget],
            :description  => email_params[:description]      
    end
end
