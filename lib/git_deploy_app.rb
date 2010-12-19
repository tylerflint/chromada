require 'sinatra'

class GitDeployApp < Sinatra::Base

  get '/deploy' do
    %{
      <form method="post" action="/deploy">
        <input type="text" name="payload" />
        <input type="submit" value="Submit" />
      </form>
    }
  end

  post '/deploy' do
    push = JSON.parse(params[:payload])
    
  end

end