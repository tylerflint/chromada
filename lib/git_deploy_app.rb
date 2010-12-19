require 'sinatra'

class GitDeployApp < Sinatra::Base

  get '/deploy' do
    "test"
  end

  post '/deploy' do
    push = JSON.parse(params[:payload])
    if push["ref"] == "refs/heads/deploy"
      `git pull`
      `bundle install`
      `service chromada reload`
    end
  end

end