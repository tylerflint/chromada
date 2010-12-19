require 'sinatra'

class GitDeployApp < Sinatra::Base

  get '/deploy' do
    `git pull`
    `bundle install`
    `service chromada reload`
    "ok"
    # %{
    #   <form method="post" action="/deploy">
    #     <input type="text" name="payload" />
    #     <input type="submit" value="Submit" />
    #   </form>
    # }
  end

  post '/deploy' do
    push = JSON.parse(params[:payload])
    if push["ref"] == "refs/heads/deploy"
      
    end
  end

end